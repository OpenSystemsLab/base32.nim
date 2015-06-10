# base32.nim

This module implements a base32 encoder and decoder.


Installation
============

    $ nimble install base32

Changes
=======

    0.1.1 - minor tweaks
    0.1.0 - initial release

Usage
=====
```nim
    import base32

    let e = encode("Hello")
    assert decode(e) == "JBSWY3DP"
```
