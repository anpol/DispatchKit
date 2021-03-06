#!/usr/bin/env python
# vim:fileencoding=utf-8
from __future__ import absolute_import, with_statement
from __future__ import division, print_function, unicode_literals

import inspect
import io
import os
from itertools import dropwhile, izip


L_WIDTH = 76-1
R_WIDTH = 88-1
SINGLE_DASHES = "+{}+{}+".format('-' * L_WIDTH, '-' * R_WIDTH)
DOUBLE_DASHES = "+{}+{}+".format('=' * L_WIDTH, '=' * R_WIDTH)
HEADER = "\n{}\n|{:^{}}|{:^{}}|\n{}".format(SINGLE_DASHES, 'Swift', L_WIDTH, 'Objective-C', R_WIDTH, DOUBLE_DASHES)
CODE_LINE = "|{:<{}}|{:<{}}|".format('.. code:: swift', L_WIDTH, '.. code:: objc', R_WIDTH)
FOOTER = SINGLE_DASHES + '\n'


def using_enums():
    """
    As shown an the previous example, the GCD constants are mapped into the Swift enumerations.

    For instance, the ``DISPATCH_QUEUE_PRIORITY_*`` constants are mapped as follows:

    .. code:: swift

        enum DispatchQueuePriority : dispatch_queue_priority_t {
            case High = DISPATCH_QUEUE_PRIORITY_HIGH
            case Default = DISPATCH_QUEUE_PRIORITY_DEFAULT
            case Low = DISPATCH_QUEUE_PRIORITY_LOW
            case Background = DISPATCH_QUEUE_PRIORITY_BACKGROUND
        }

    Actual mapping is performed by the Swift compiler behind the scenes. Refer to
    `dk_enums.h <DispatchKit/dk_enums.h>`_ for the corresponding Objective-C code.
    """


def using_time():
    """
    The previous example uses time expressions. Other forms of time expressions are also possible:

    .. code:: swift

        .Now + .Seconds(3) + .Milliseconds(145) + .Microseconds(926) + .Nanoseconds(535)
        .WallClock(timespec) + .Days(5) + .Hours(40)

    Refer to `DispatchTime.swift <DispatchKit/DispatchTime.swift>`_ for further details.

    An additional ``.Forever`` constant is used by default with ``wait()`` method defined
    for groups and semaphores.
    """


def readlines(filename):
    lines = (line.rstrip('\r\n') for line in open(filename))
    lines = dropwhile(lambda line: not line.endswith('{'), lines)
    lines = dropwhile(lambda line: not line.startswith('//'), lines)
    return lines


def main():
    os.chdir(os.path.dirname(__file__))
    l_lines = readlines('CheatSheet.swift')
    r_lines = readlines('CheatSheet.m')

    print('.. DO NOT EDIT. THIS FILE IS GENERATED BY', os.path.basename(__file__))

    have_header = False
    for (l, r) in izip(l_lines, r_lines):
        assert isinstance(l, unicode) and isinstance(r, unicode)

        if l.startswith('//'):
            if have_header:
                have_header = False
                print(FOOTER)

            title = l[2:].lstrip()
            if title != '@end':
                print('\n', title, '\n', '-' * len(title), sep='')
                if title == 'Using Enumerations':
                    print('\n', inspect.getdoc(using_enums), '\n', sep='')
                elif title == 'Using Time':
                    print('\n', inspect.getdoc(using_time), '\n', sep='')
                else:
                    have_header = True
                    print(HEADER)
                    print(CODE_LINE)

        else:
            print("|{:<{}}|{:<{}}|".format(l[1:], L_WIDTH, r[1:], R_WIDTH))

if __name__ == '__main__':
    main()
