#!/usr/bin/sh

for f in .xinitrc .gitconfig; do
    rm -f ~/${f}
    ln -s ~/.dotfiles/${f} ~/${f}
done

mkdir -p ~/.config

for f in fish i3 kitty nvim polybar systemd tmux yay Xmodmap; do
    rm -f ~/.config/${f}
    ln -s ~/.dotfiles/${f} ~/.config/${f}
done

chsh -s /usr/bin/fish
