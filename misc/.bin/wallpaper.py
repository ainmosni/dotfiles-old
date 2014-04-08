#!/usr/bin/env python2

import glob
import random
import os.path
import time
import subprocess

wallpaper_path = '/home/daniel/Dropbox/Wallpaper/'

while True:
    files = glob.glob(wallpaper_path + '*')
    w1 = w2 = w3 = ''
    while not (os.path.isfile(w1)
               and os.path.isfile(w2)
               and os.path.isfile(w3)):
        w1 = random.choice(files)
        w2 = random.choice(files)
        w3 = random.choice(files)

    cmd = 'feh --bg-scale {} {} {}'.format(w1, w2, w3)
    subprocess.call(cmd.split())
    time.sleep(60*30)
