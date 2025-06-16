source ~/a/scripts/.startup
fpath+=~/.zfunc
fpath=(~/.zfunc $fpath)
autoload -U compinit && compinit
