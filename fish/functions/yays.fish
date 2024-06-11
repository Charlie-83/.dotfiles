function yays
    yay -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro yay -S
end
