# Navigating Endgame

## 👋 About Endgame

Endgame enables you and anyone at your company to deeply understand your customers and prospects. Consider Endgame a single sheet of music for the entire team to use for sales and account management use cases such as company research, meeting prep, account planning, deal review, handoffs, and more.

At its heart, Endgame is about going deep on a given account. After you [login](https://end-p1.endgame.io/login) with your Salesforce credentials, you’ll be presented with Endgame’s [home page](https://end-p1.endgame.io/) (screenshot below). This page is intended to get you to the account you want to dig into as quickly as possible.

![Screenshot 2025-05-16 at 8.52.38 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/Screenshot_2025-05-16_at_8.52.38_AM.png)

## 🔍 Getting to an account: Direct search

Type in the name of the company or person you want to research in the home page search box. Doing so will pull up accounts and people to select from — simply click the appropriate account and you’ll be taken to the Account Detail page (or Person Thread). 

![image.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/image.png)

<aside>
💡

You can also directly go to search via cmd+k from any page or by clicking the search icon in the left-hand navigation.

</aside>

***It’s important to note that the only companies you will see are those with Account records in Salesforce that Endgame has been given access to.***

## 📂 Getting to an account: Account list view

Alternatively, navigate to the [Account List](https://end-p1.endgame.io/accounts) page by clicking the stack icon in the left-hand navigation. There are a few ways to sort and filter this table.

![Screenshot 2025-05-16 at 8.54.20 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/Screenshot_2025-05-16_at_8.54.20_AM.png)

### 👥 Filtering by ownership

Clicking the people icon at the top right of the list will provide a menu with a few mechanisms for filtering with ownership in mind. 

You can combine ownership filters with [quick filters](https://www.notion.so/1f40ee6f29db80cf80fcf4e22369f600?pvs=21).

- Filter to “my accounts”, which looks for accounts in which you are the Account Owner in the default Salesforce “Account Owner” field in related Salesforce Account records.
- Filter to accounts owned by any user in  Salesforce by searching for their name.
- Filter to accounts where you, or the selected user, has “any role”—this will take into account custom ownership fields, typically used for Sales Engineers, Customer Success Managers, Account Managers, SDRs, BDRs, etc.
- Filter to accounts owned by your team, which relies on the [manager field for users](https://help.salesforce.com/s/articleView?id=ind.tpm_admin_task_manager_for_payments.htm&type=5) in Salesforce.

![Screenshot 2025-05-16 at 8.58.41 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/Screenshot_2025-05-16_at_8.58.41_AM.png)

![Screenshot 2025-05-16 at 9.02.41 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/Screenshot_2025-05-16_at_9.02.41_AM.png)

### ⏩ Quick filters

The top left Accounts dropdown allows you to look at All Accounts, Lost Deals, and Open Opportunities. You can also quickly filter down to your Favorite accounts or sort by recency of interaction

Accounts can be designated as Favorites directly from the Account List by using the star icon next to the logo, or from any Account detail page using the star icon at the top right corner. 

You can combine these filters with ownership filters.

![Screenshot 2025-05-16 at 9.03.31 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/Screenshot_2025-05-16_at_9.03.31_AM.png)

### ↕️ Sorting

There are a few pre-built ways to sort the list: by Account Name, Opportunity Size, Opportunity Close Date, Opportunity Stage, and Opportunity Type. This dropdown menu can be found at the top right of the Account List.

![Screenshot 2025-05-16 at 9.05.19 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/db6e5cde-a06f-49a7-bdfd-3781efe06af2.png)

---

## 📄 Account detail page

Once you get to an account, you’ll be presented with the Account Detail page. There are three core concepts within this page: Ask AI (chat), Timeline, and Library.

![Screenshot 2025-05-16 at 9.12.01 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/Screenshot_2025-05-16_at_9.12.01_AM.png)

### 💬 Chat

![Screenshot 2025-05-16 at 9.13.24 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/Screenshot_2025-05-16_at_9.13.24_AM.png)

Think of this as a ChatGPT that’s deeply tuned to your business model and sales strategy with  access to your internal CRM & call data. The questions you can ask can thus be quite detailed and specific. Here’s a [quick guide on prompts](Endgame%20Chat%20101%20Prompt%20suggestions%201f50ee6f29db8043ae8ec93e7b13e59a.md) to help you get started. 

<aside>
💡

Explore different angles of questions and account exploration by clicking from the rotating set of questions we’ve provided to help get you started

</aside>

When you ask a question, you’ll be taken to a new page that represents the Thread of your chat conversation. You can ask multiple questions in that Thread, and you can always get back to it from the Library.

### ⌚Timeline

The timeline captures news, people changes, financial highlights such as earnings calls, emails, and calls. It can be very useful for catching up on an account as a manager, or during account transitions/inheritance. 

![Screenshot 2025-05-16 at 11.06.18 AM.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/Screenshot_2025-05-16_at_11.06.18_AM.png)

The timeline is searchable via the box in the top left for specific terms, and selecting any of the category tags (Email, Meeting, Job Change, News) in the second column will also instantly filter the timeline to that tag type (select again to remove the filter). 

For accounts that have a large number of timeline events, you can also toggle from All Activity to Highlights to narrow down to events that Endgame believes are of heightened importance.

Clicking into any specific event will open up a new chat Thread, where you can explore the event in greater detail. For example, you can click into a past meeting, and the new thread will automatically generate a summary of the meeting for you from which you can ask follow on questions.

### 📚 Library

The Library contains an index of Threads, which is your Ask AI chat history in that account. This allows you to quickly go back to any chat you have had regarding the account as well as provide a mechanism for collaboration with other members of your team.

The Library is divided into Threads with Artifacts and Threads that have not been [published as Artifacts](Publishing%20&%20Artifacts%2021d0ee6f29db804785d0df58896a9ba4.md).

- Artifacts are Threads that have been published, which enables external sharing of a Thread via a link with non-Endgame users. Publishing a Thread will also make the thread public and viewable by other Endgame users in the Account Library.
- Threads which have not been published will be available in the Threads section of the Library and will persist unless it is manually deleted. These Threads are only visible in the Library to the creator of the Thread, though it is still possible to manually share the link to the Thread with other Endgame users.

![image.png](Navigating%20Endgame%201f50ee6f29db80bc9621efedda2f49da/image%201.png)

---

## **💁‍♀️ Need help or have feedback?**

We’d love to hear from you! You can reach us at [**support@endgame.io**](mailto:support@endgame.io).