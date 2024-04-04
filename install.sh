#!/usr/bin/env bash

os_version=""
prerequisite() {
    local os_name_lowercase="$(uname -a | tr '[:upper:]' '[:lower:]')"
    if grep -q '^linux.*microsoft' <<< "$os_name_lowercase"
    then
        os_version="windows"
        install wslu
    elif grep -q 'darwin' <<< "$os_name_lowercase"
    then
    	os_version="osx"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        install coreutils
    elif grep -q 'linux' <<< "$os_name_lowercase"
    then
        os_version="linux"
    else
        echo "OS not recognized : $(uname -a)"
        echo "Must be wsl2, osx or linux"
        exit 1
    fi
}

install() {
    case "$os_version" in
        linux | windows)
            sudo apt install -y "$@"
        ;;
        osx)
            brew install "$@"
        ;;
        *)
            echo "OS not recogized : $os_version"
            exit 1
        ;;
    esac
}

prerequisite

install tmux neovim curl git zsh

curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash
install nodejs

git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"

if [[ "$os_version" != "osx" ]]; then
    sudo update-alternatives --config vi
    git config --global core.editor "vi"
else
    git config --global core.editor "nvim"
fi

chsh -s $(which zsh)

# Neovim Plug setup
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim "+:PlugInstall"

echo Installation done.
echo You should install a powerfont and use it in your terminal.
echo For instance :
echo https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/DejaVuSansMNerdFontMono-Regular.ttf
