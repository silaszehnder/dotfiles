RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"

function parse_git_branch() {
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

# Mac specific
if [ $(uname) == 'Darwin' ]; then
    # Homebrew-related
    export HOMEBREW_PREFIX="/opt/homebrew"
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
    export HOMEBREW_REPOSITORY="/opt/homebrew"
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

    # Silence the bash -> zsh warning
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Add custom scripts to path
export PATH=~/.scripts:$PATH

# Add local bin to PATH
export PATH=~/.local/bin:$PATH

# Add local go bins to PATH
export PATH=$PATH:/usr/local/go/bin

# Add esp32 toolchain to path
export PATH="$PATH:$HOME/esp/xtensa-esp32-elf/bin"
export IDF_PATH=~/esp/esp-idf

# Add poetry to path
export PATH="$HOME/.poetry/bin:$PATH"

# vimwiki
export VIMWIKI_MARKDOWN_EXTENSIONS="toc"

# Load our other dotfiles.
for file in ~/.{aliases,aliases_private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Use this file for tasks/reminders/etc.
[ -e ~/.motd ] && cat ~/.motd

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

. "$HOME/.cargo/env"
