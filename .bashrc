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

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Add custom scripts to path
export PATH=~/.scripts:$PATH

# Add local bin to PATH
export PATH=~/.local/bin:$PATH

# Add esp32 toolchain to path
export PATH="$PATH:$HOME/esp/xtensa-esp32-elf/bin"
export IDF_PATH=~/esp/esp-idf

# vimwiki
export VIMWIKI_MARKDOWN_EXTENSIONS="toc"

# X1 tablet (wayland) specific
# alias webcam="ffplay -f v4l2 -video_size 640x480 -i /dev/video16"
# alias capturewebcam='ffmpeg -f v4l2 -i /dev/video16 -map 0 -c:v libx264 -f tee "capture.mp4|[f=nut]pipe:" | ffplay -an -probesize 32 -sync ext pipe:'

# Load our other dotfiles.
for file in ~/.{aliases,aliases_private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Use this file for tasks/reminders/etc.
[ -e ~/.motd ] && cat ~/.motd
