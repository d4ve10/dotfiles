#!/usr/bin/env bash
DOTFILES=${HOME}/.dotfiles

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles..."
"$DOTFILES/stow_env" -S $(ls "$DOTFILES/files/")

source "$DOTFILES/install/git.sh"

zsh_path="$(command -v zsh)"

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif [[ "$SHELL" != "$zsh_path" ]]; then
    echo "Configuring zsh as default shell"
    chsh -s "$zsh_path"
    echo "default shell changed to $zsh_path"
fi

echo "Installing oh-my-zsh..."

git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.config/oh-my-zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/themes/powerlevel10k
echo "Download the autojump package (Optional)"

echo "Done. Reload your terminal."
