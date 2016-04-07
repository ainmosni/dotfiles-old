#!/bin/bash

LANG=en_US.UTF-8
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/android-sdk/tools:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/local/sbin:/usr/local/bin:/usr/bin/vendor_perl/:/home/daniel/.bin:/home/daniel/.sbin"

font="Roboto Mono-12"

dmenu_run -i -h 1080 -w 1920 -q -o .9 -p " execute" -fn "$font" -nb "#000000" -nf "#bbbbbb" -sb "#000000" -sf "#850000" > /tmp/output 2>&1
