if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if [ "$(uname)" == "Linux" ]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi
