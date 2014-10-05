#!/usr/bin/env python
# coding: utf-8

import subprocess
import re
import argparse
import os

import pyinotify

class OnWriteHandler(pyinotify.ProcessEvent):
    """
    Simple on write handler.
    """
    def my_init(self, watch_path, destination_path, exclusions=None,
                rsync_path='/usr/bin/rsync'):
        self.watch_path = watch_path
        self.destination_path = destination_path
        self.exclusions = exclusions
        self.cmd = '{} -avz --delete {} {}'.format(rsync_path,
                                                   watch_path,
                                                   destination_path)

    def process_IN_MODIFY(self, event):
        print('===> {} got modified.'.format(event.pathname))
        self.sync(event)

    def process_IN_DELETE(self, event):
        print('===> {} got deleted.'.format(event.pathname))
        self.sync(event)

    def process_IN_MOVED_TO(self, event):
        print('===> {} moved into our watchspace'.format(event.pathname))
        self.sync(event)

    def sync(self, event):
        if self.exclusions and self._is_excluded(event.pathname):
            print('===> {} is excluded'.format(event.pathname))
            return

        print('===> Syncing {} to {}'.format(self.watch_path,
                                             self.destination_path))
        subprocess.check_output(self.cmd.split())

    def _is_excluded(self, string):
        for pattern in self.exclusions:
            if re.search(pattern, string):
                return True

        else:
            return False


def parse_arguments():
    parser = argparse.ArgumentParser(
        description='Mirror a directory via rsync.')
    parser.add_argument('watch_path',
                        nargs=1,
                        help='Path to mirror from.')
    parser.add_argument('dest_path',
                        nargs=1,
                        help='Rsync path to mirror to.')
    parser.add_argument('-e', '--exclude',
                        action='append',
                        help='Patterns to exclude.',
                        dest='exclusions')
    parser.add_argument('-r', '--rsync-path',
                        nargs=1,
                        help='Path to rsync.',
                        dest='rsync_path',
                        default='/usr/bin/rsync')
    return parser.parse_args()


def auto_mirror(watch_path,
                destination_path,
                rsync_path,
                exclusions=None):
    """

    :param path: Path to upload to.
    :param exclusions: Excluded patterns.
    :returns: None

    """
    # Fix slashes at the end of paths for rsync.
    watch_path = watch_path if watch_path.endswith('/') else watch_path + '/'
    destination_path = (destination_path if destination_path.endswith('/')
                        else destination_path + '/')
    wm = pyinotify.WatchManager()
    handler = OnWriteHandler(watch_path=watch_path,
                             destination_path=destination_path,
                             exclusions=exclusions,
                             rsync_path=rsync_path)
    notifier = pyinotify.Notifier(wm, default_proc_fun=handler)
    wm.add_watch(watch_path, pyinotify.ALL_EVENTS, rec=True, auto_add=True)
    print('===> Started monitoring {}.'.format(watch_path))
    notifier.loop()

if __name__ == '__main__':
    arguments = parse_arguments()
    watch_path = os.path.expanduser(arguments.watch_path[0])
    dest_path = os.path.expanduser(arguments.dest_path[0])
    auto_mirror(watch_path,
                dest_path,
                arguments.rsync_path,
                arguments.exclusions)
