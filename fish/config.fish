if status is-interactive
    # Commands to run in interactive sessions can go here
    export PATH="$PATH:/opt/flutter/bin:/home/charlie/.local/share/gem/ruby/3.0.0/bin"
end

if test -z $DISPLAY && test 1 -eq $XDG_VTNR
    exec startx
end

function fish_prompt
    if test (prompt_pwd) != "~"
        set_color $fish_color_cwd
        echo -n (prompt_pwd)
        set_color normal
        echo -n (fish_git_prompt)
    end
    set_color green
    echo -n '🐸->>'
end

function fish_postexec --on-event fish_postexec
    echo -e "\a"
end

# API key env variables
source ~/.config/api.fish

set -x MANPAGER "nvim -u ~/.dotfiles/nvim/kitty_scrollback.lua +Man!"

set -x VISUAL nvim

set -x INPUTRC $HOME/.dotfiles/inputrc
