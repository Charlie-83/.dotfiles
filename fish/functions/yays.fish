function yays
    yay -Slq | fzf --multi --preview 'yay -Si {1}' --preview-window=up,wrap | xargs -ro yay -S
end
