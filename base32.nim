#
#          Nim's Unofficial Library
#        (c) Copyright 2015 Huy Doan
#
#    See the file "LICENSE", included in this
#    distribution, for details about the copyright.
#

## This module implements a base32 encoder and decoder.

const
  VERSION* = "0.1.1"

  base32Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567="

proc encode*(s: string): string =
  var i, j, idx, digit: int = 0
  var current, next: int

  var len = (s.len * 8 / 5).int
  if len mod 8 != 0:
     len += 8 - (len mod 8)

  result = newString(len)

  while i < s.len:
    current = s[i].ord
    if current == 0:
      current = 256;

    if idx > 3:
      if i + 1 < s.len:
        next = s[i+1].ord
        if next == 0:
          next = 256
      else:
        next = 0

      digit = current and (0xFF shr idx)
      idx = (idx + 5) mod 8
      digit = digit shl idx
      digit = digit or (next shr (8 - idx))

      i += 1
    else:
      digit = (current shr (8 - (idx + 5))) and 0x1F
      idx = (idx + 5) mod 8
      if idx == 0:
        i += 1

    result[j] = base32Chars[digit]
    j += 1
  if j < len:
    for i in j..len-1:
      result[i] = base32Chars[32]


proc decode*(s: string): string =
  var ch, idx, bits, buf: int = 0
  let len = (s.len * 5 / 8).int

  result = newString(len)

  for i in 0..s.len-1:
    ch = s[i].ord

    case ch
    of 0x41..0x5A, 0x61..0x7A:
      ch = (ch and 0x1F) - 1
    of 0x32..0x37:
      ch -= 0x32 - 26
    of 0x3D:
      continue
    else:
      raise newException(ValueError, "Non-base32 digit found: " & $ch)

    buf = buf shl 5
    buf = buf xor ch
    bits += 5

    if bits >= 8:
      bits -= 8
      result[idx] = char(buf shr bits and 0xFF)
      idx += 1
  if idx < len:
    setLen(result, idx)
