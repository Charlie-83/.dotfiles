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



function jn
    jj new $argv
end
function jd
    jj desc $argv
end
function jl
    jj log $argv
end
function je
    jj edit $argv
end
function js
    jj show $argv
end
function jsq
    jj squash $argv
end
function jsi
    jj squash -i $argv
end
function jgp
    jj git push
end
function jlh 
   if count $argv > /dev/null
      jl -r '::@' -n $argv
   else
       jl -r '::@' -n 10
   end 
end
function jbm
    jj bookmark move $argv
end
