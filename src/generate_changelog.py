#!/usr/bin/env python3
import typer
from typing import List, Tuple, Optional
from pathlib import Path
import re
from datetime import datetime
from dateutil import parser as date_parser
import sys
import shutil

app = typer.Typer()


def read_changelog_entry(file_path: Path) -> Tuple[str, str, str, str]:
    """Read a changelog entry and extract title, content, and links.
    
    Returns:
        (title, content, links, full_content)
    """
    with open(file_path, 'r') as f:
        content = f.read()
    
    lines = content.strip().split('\n')
    
    # Extract title (first line without #)
    title = lines[0].lstrip('#').strip() if lines else ""
    
    # Find where links section starts
    links_index = None
    for i, line in enumerate(lines):
        if line.strip().startswith('Links:'):
            links_index = i
            break
    
    if links_index is not None:
        # Content is between title and links
        content_lines = lines[1:links_index]
        links_lines = lines[links_index:]
    else:
        # No links section
        content_lines = lines[1:]
        links_lines = []
    
    # Join content and strip whitespace
    content_text = '\n'.join(content_lines).strip()
    links_text = '\n'.join(links_lines)
    
    return title, content_text, links_text, content


def extract_date_from_filename(filename: str) -> datetime:
    """Extract date from filename like 2025_03_03_pr3838.change.md"""
    match = re.match(r'(\d{4})_(\d{2})_(\d{2})_', filename)
    if match:
        year, month, day = match.groups()
        return datetime(int(year), int(month), int(day))
    raise ValueError(f"Could not extract date from filename: {filename}")


def format_date_for_label(date: datetime) -> str:
    """Format date for the Update label (e.g., 'March 3, 2025')"""
    return date.strftime('%B %-d, %Y')


def format_date_for_anchor(date: datetime) -> str:
    """Format date for the anchor link (e.g., 'march-3-2025')"""
    return date.strftime('%B-%-d-%Y').lower()


def parse_existing_changelog(file_path: Path) -> Tuple[str, dict]:
    """Parse existing changelog.mdx and extract frontmatter and Update components.
    
    Returns:
        (frontmatter, dict of date -> list of entry texts)
    """
    if not file_path.exists():
        return """---
title: "Changelog"
description: "Product updates and announcements"
rss: true
---

""", {}
    
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Extract frontmatter
    frontmatter_match = re.match(r'^(---\n.*?\n---\n\n)', content, re.DOTALL)
    if frontmatter_match:
        frontmatter = frontmatter_match.group(1)
        content_after_frontmatter = content[len(frontmatter):]
    else:
        frontmatter = """---
title: "Changelog"
description: "Product updates and announcements"
rss: true
---

"""
        content_after_frontmatter = content
    
    # Extract Update components
    updates_by_date = {}
    update_pattern = r'<Update label="([^"]+)"[^>]*>(.*?)</Update>'
    
    for match in re.finditer(update_pattern, content_after_frontmatter, re.DOTALL):
        label = match.group(1)
        update_inner_content = match.group(2).strip()
        
        # Parse date from label (e.g., "June 20, 2025")
        try:
            date = datetime.strptime(label, '%B %d, %Y')
            
            # Parse multiple entries within the same Update
            # Entries are separated by double newlines and start with **Title**
            entries = []
            entry_pattern = r'\*\*[^*]+\*\*\n\n[\s\S]*?(?=\n\n\*\*|$)'
            found_entries = re.findall(entry_pattern, update_inner_content)
            
            if found_entries:
                entries = [e.strip() for e in found_entries]
            else:
                # If no pattern matches, treat the whole content as one entry
                entries = [update_inner_content]
            
            if date not in updates_by_date:
                updates_by_date[date] = []
            updates_by_date[date].extend(entries)
        except ValueError:
            # If we can't parse the date, skip this update
            continue
    
    return frontmatter, updates_by_date


def prompt_for_entry(title: str, content: str, date: datetime) -> Tuple[bool, Optional[str], Optional[str]]:
    """Prompt user to accept, reject, or edit an entry.
    
    Returns:
        (accepted, edited_title, edited_content)
    """
    typer.echo("\n" + "="*60)
    typer.echo(f"Date: {date.strftime('%B %-d, %Y')}")
    typer.echo(f"Title: {title}")
    typer.echo(f"Content:\n{content}")
    typer.echo("="*60)
    
    while True:
        choice = typer.prompt("\n[A]ccept, [R]eject, or [E]dit?", type=str).lower()
        
        if choice == 'a':
            return True, title, content
        elif choice == 'r':
            return False, None, None
        elif choice == 'e':
            edited_title = typer.prompt("New title", default=title)
            typer.echo("Enter new content (press Ctrl+D when done):")
            try:
                edited_content = sys.stdin.read()
            except KeyboardInterrupt:
                edited_content = content
            return True, edited_title, edited_content.strip()
        else:
            typer.echo("Invalid choice. Please enter A, R, or E.")


@app.command()
def main():
    """Generate changelog.mdx from changelog entries in internal/changelog/candidates/"""
    
    # Setup paths
    changelog_dir = Path("internal/changelog/candidates")
    output_file = Path("mintlify/changelog.mdx")
    output_entries_dir = Path("mintlify/changelog_entries")
    rejected_dir = Path("internal/changelog/rejected")
    
    # Create output directories if they don't exist
    output_file.parent.mkdir(exist_ok=True)
    output_entries_dir.mkdir(exist_ok=True)
    rejected_dir.mkdir(parents=True, exist_ok=True)
    
    # Read all changelog files
    changelog_files = sorted(changelog_dir.glob("*.change.md"), reverse=True)
    
    if not changelog_files:
        typer.echo("No changelog files found!")
        raise typer.Exit(1)
    
    # Process entries
    accepted_count = 0
    
    for file_path in changelog_files:
        # Skip if already processed (exists in changelog_entries)
        if (output_entries_dir / file_path.name).exists():
            continue
            
        # Skip if already rejected (but delete if 0 bytes)
        rejected_path = rejected_dir / file_path.name
        if rejected_path.exists():
            if rejected_path.stat().st_size == 0:
                rejected_path.unlink()
                typer.echo(f"🗑️  Deleted 0-byte rejected file: {file_path.name}")
            else:
                continue
            
        title, content, links, full_content = read_changelog_entry(file_path)
        
        # Skip internal entries
        if "INTERNAL" in full_content:
            continue
        
        # Extract date from filename for display
        try:
            date = extract_date_from_filename(file_path.name)
        except ValueError:
            # If we can't extract date, skip this file
            continue
        
        # Prompt user
        accepted, edited_title, edited_content = prompt_for_entry(title, content, date)
        
        if accepted:
            try:
                # Save edited entry to changelog_entries
                edited_entry_path = output_entries_dir / file_path.name
                edited_full_content = f"# {edited_title}\n\n{edited_content}\n\n{links}".strip() + "\n"
                with open(edited_entry_path, 'w') as f:
                    f.write(edited_full_content)
                
                # Create the entry text with indented description
                indented_content = '\n'.join(f"  {line}" if line else "" for line in edited_content.split('\n'))
                entry_text = f"**{edited_title}**\n\n{indented_content}"
                
                # Parse existing changelog
                frontmatter, existing_updates_by_date = parse_existing_changelog(output_file)
                
                # Add new entry to the appropriate date
                if date not in existing_updates_by_date:
                    existing_updates_by_date[date] = []
                existing_updates_by_date[date].append(entry_text)
                
                # Generate consolidated changelog
                mdx_content = frontmatter
                
                # Sort dates in reverse chronological order
                for update_date in sorted(existing_updates_by_date.keys(), reverse=True):
                    entries = existing_updates_by_date[update_date]
                    label = format_date_for_label(update_date)
                    
                    # Combine entries for this date
                    content_text = "\n\n".join(entries)
                    
                    mdx_content += f"""<Update label="{label}">
{content_text}
</Update>

"""
                
                with open(output_file, 'w') as f:
                    f.write(mdx_content.strip() + "\n")
                
                accepted_count += 1
                typer.echo(f"✅ Added to changelog and saved a copy to {edited_entry_path.name}")
                
            except ValueError as e:
                typer.echo(f"Error processing {file_path.name}: {e}")
                continue
        else:
            # Move rejected file to rejected directory
            rejected_path = rejected_dir / file_path.name
            shutil.move(str(file_path), str(rejected_path))
            typer.echo(f"Moved {file_path.name} to rejected directory")
    
    typer.echo(f"\n✅ Processed all changelog entries")
    typer.echo(f"✅ Added {accepted_count} entries to {output_file}")


if __name__ == "__main__":
    app()