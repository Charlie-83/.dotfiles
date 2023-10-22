if status is-interactive
    # Commands to run in interactive sessions can go here
    export PATH="$PATH:/opt/flutter/bin"
end

if test -z $DISPLAY && test 1 -eq $XDG_VTNR
    exec startx
end
