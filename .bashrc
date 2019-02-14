alias ls='ls -GF --color=auto'
alias ebrc="vim $HOME/.bashrc"
alias sbrc="source ~/.bashrc"
alias evrc="vim $HOME/.vimrc"
alias gits="git status"
alias gita="git add -A"
alias gitcm="git commit -m"
alias gitd="git diff"
alias gitg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"


alias weatheraa='curl http://wttr.in/ann_arbor?Tn1'
alias weather3aa='curl http://wttr.in/ann_arbor?Tn | less'
alias weatherm='curl http://wttr.in/broomfield?Tn1'
alias weather3m='curl http://wttr.in/broomfield?Tn | less'

alias screenfetch="screenfetch -E"
alias parrot="terminal-parrot"

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"


function parse_git_branch {
	PS_BRANCH=''
	if [ -d .svn ]; then
		PS_BRANCH="(svn r$(svn info|awk '/Revision/{print $2}'))"
		return
		elif [ -f _FOSSIL_ -o -f .fslckout ]; then
			PS_BRANCH="(fossil $(fossil status|awk '/tags/{print $2}')) "
			return
		fi
			ref=$(git symbolic-ref HEAD 2> /dev/null) || return          
			PS_BRANCH="(git ${ref#refs/heads/}) "
}
PROMPT_COMMAND=parse_git_branch
PS_GIT="$RED\$PS_BRANCH" 


export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\t:\[\033[33;1m\]\w\[\033[m\] ${PS_GIT}\n${RESET}\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# autojump
source /etc/profile.d/autojump.bash

# Add custom scripts to path
export PATH=~/.scripts:$PATH

# Add esp32 toolchain to path
export PATH="$PATH:$HOME/esp/xtensa-esp32-elf/bin"
export IDF_PATH=~/esp/esp-idf

#GIT_PROMPT_ONLY_IN_REPO=1
#source ~/.bash-git-prompt/gitprompt.sh

