from math import ceil

const
  base32Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"


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
      result[i] = '='
