=======================================================
 DispatchKit – iOS and OS X Framework written in Swift
=======================================================

.. vim:spell:spelllang=en
.. contents::


Goal
====

The project aims to provide an idiomatic Swift language wrapper for the
`Grand Central Dispatch`_ Framework, also known as GCD, or libdispatch_ library.

    Current implementation is based on publicly available `Swift prerelease`_ and
    `GCD prerelease`_ documentation. The implementation is subject to change.

If you are familiar with the C-based GCD API, you can continually apply your knowledge
when writing Swift code, because the DispatchKit API closely matches the original API.

Otherwise, if you have little or no experience with GCD, then probably the DispatchKit is
a good place to start playing with, as it allows you to learn GCD in a much more cleaner way.
Swift is a more type safe and less error-prone language than Objective-C, and the DispatchKit
uses strict types and short method names to wrap GCD types and functions.

In addition, the DispatchKit is assumed to have zero overhead compared to GCD code written
in C or Objective-C using the original API. That's because DispatchKit wrappers are just
tiny structs, which do not require expensive memory allocation themselves.


Usage
=====

Usage examples are provided in Swift using DispatchKit, compared to Objective-C code
using the original GCD API.

.. include:: Examples/CheatSheet.rst


Dispatch I/O
------------

For details, refer to
`DispatchIO.swift <DispatchKit/DispatchIO.swift>`_ and
`DispatchData.swift <DispatchKit/DispatchData.swift>`_.


Dispatch Sources
----------------

For details, refer to
`DispatchSource.swift <DispatchKit/DispatchSource.swift>`_ and various flags declared in
`DispatchSourceType.swift <DispatchKit/DispatchSourceType.swift>`_ and
`dk_enums.h <DispatchKit/dk_enums.h>`_.


Compatibility
=============

The DispatchKit is designed to be source-compatible with iOS 7 SDK, binary-compatible with iOS 7 platform.

    More information could be provided after a subsequent release of iOS 8.


License 
=======

The DispatchKit is available under the `MIT License <LICENSE.rst>`_.


.. References:
.. _Grand Central Dispatch: https://developer.apple.com/library/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/
.. _libdispatch: http://libdispatch.macosforge.org
.. _Swift prerelease: https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/
.. _GCD prerelease: https://developer.apple.com/library/prerelease/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/index.html

