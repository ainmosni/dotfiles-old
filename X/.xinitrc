#!/bin/sh #
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap 'us(altgr-intl)' &
xmodmap ~/.Xmodmaprc &
xset b 8 &

DEFAULT_SESSION=i3

case $1 in
i3)
    exec ck-launch-session ssh-agent i3
    ;;
cinnamon)
    exec ck-launch-session cinnamon
    ;;
xbmc)
    exec xbmc
    ;;
*)
    exec ck-launch-session ssh-agent $DEFAULT_SESSION
    ;;
esac
