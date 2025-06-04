RESET="\[\033[0m\]"
BRED="\[\033[1;31m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BYELLOW="\[\033[1;33m\]"
CYAN="\[\033[0;36m\]"

PROMPT_COMMAND=_prompt_cmd

_prompt_cmd() {
    # parse exit code
    _cmd_exit="$?"
    _exit_pre="$GREEN("
    _exit_post=")$RESET"
    if [ $_cmd_exit != 0 ]; then
        _exit_pre="$BRED("
    fi

    _ps_exit="$_exit_pre$_cmd_exit$_exit_post"

    # parse git branch
    _ps_branch=''
    if [ -d .svn ]; then
        _ps_branch="(svn r$(svn info|awk '/Revision/{print $2}'))"
    elif [ -f _FOSSIL_ -o -f .fslckout ]; then
        _ps_branch="(fossil $(fossil status|awk '/tags/{print $2}')) "
    fi
        ref=$(git symbolic-ref HEAD 2> /dev/null)
        if [[ -z $ref ]]; then
            _ps_branch=""
        else
            _ps_branch="(git ${ref#refs/heads/}) "
        fi

    # parse virtual_env
    _virtual_env_info=''
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && _virtual_env_info="$BYELLOW($venv) $RESET"

    # PS1
    PS1="$_ps_exit "
    PS1+="$_virtual_env_info"
    PS1+="$CYAN\u$RESET"
    PS1+="@"
    PS1+="$GREEN\t$RESET"
    PS1+=":"
    PS1+="$YELLOW\w$RESET "
    PS1+="$RED$_ps_branch\n$RESET\$ "
}

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

# Prepend `history` entries with a timestamp
export HISTTIMEFORMAT="%F %T "

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Add custom scripts to path
export PATH=~/.scripts:$PATH

# Add local bin to PATH
export PATH=~/.local/bin:$PATH

# Add local go bins to PATH
export PATH=$PATH:/usr/local/go/bin

# Add rust bins to PATH
export PATH=$PATH:~/.cargo/bin

# Add esp32 toolchain to path
export PATH="$PATH:$HOME/esp/xtensa-esp32-elf/bin"
export IDF_PATH=~/esp/esp-idf

# Add poetry to path
export PATH="$HOME/.poetry/bin:$PATH"

export PATH="/Library/TeX/texbin:$PATH"

# vimwiki
export VIMWIKI_MARKDOWN_EXTENSIONS="toc"

# Load our other dotfiles.
for file in ~/.{aliases,aliases_private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Use this file for tasks/reminders/etc.
# [ -e ~/.motd ] && cat ~/.motd

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
