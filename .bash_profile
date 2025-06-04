if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if [ "$(uname)" == "Linux" ]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

. "$HOME/.cargo/env"
