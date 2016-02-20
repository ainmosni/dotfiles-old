#!/bin/bash

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/android-sdk/tools:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/local/sbin:/usr/local/bin:/usr/bin/vendor_perl/:/home/daniel/.bin:/home/daniel/.sbin"

echo $PATH > /tmp/launcher
font="Liberation Mono for Powerline-12"

dmenu_run -i -h 1080 -w 1920 -q -o .9 -p " execute" -fn "$font" -nb "#000000" -nf "#bbbbbb" -sb "#000000" -sf "#850000"
