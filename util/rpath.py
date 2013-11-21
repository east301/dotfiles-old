#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

import argparse
import os
import sys


def _main():
    """DOCUMENT ME"""

    #
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--directory', type=int, default=0)
    parser.add_argument('-n', '--no-newline', action='store_true')
    parser.add_argument('target')
    args = parser.parse_args()

    #
    target = args.target
    if os.path.islink(args.target):
        target = os.readlink(target)

    target = os.path.abspath(target)

    for x in range(args.directory):
        target = os.path.dirname(target)

    #
    sys.stdout.write(target + ('' if args.no_newline else '\n'))


if __name__ == '__main__':
    _main()
