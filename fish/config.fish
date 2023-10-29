if status is-interactive
    # Commands to run in interactive sessions can go here
    export PATH="$PATH:/opt/flutter/bin"
    fzf_key_bindings
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
    echo -n '->>'
end

function tv
    xrandr --output DP-1 --same-as eDP-1 --scale 0.5x0.5 --output eDP-1 --scale 1x1
    pactl set-card-profile 0 output:hdmi-stereo
end
