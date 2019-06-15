import ../base32
import unittest, strutils

suite "Strings":
  var e = encode("Hello")
  test e:
    check e == "JBSWY3DP"

  var d = decode(e)
  test d:
    check d == "Hello"

  var vietnam = "Socialist Republic of Vietnam"
  e = encode(vietnam)
  test e:
    check e == "KNXWG2LBNRUXG5BAKJSXA5LCNRUWGIDPMYQFM2LFORXGC3I="

  d = decode(e)
  test d:
    check d == vietnam

suite "RFC4648":
  proc BASE32(raw, b32: string) =
    test raw:
      check b32 == encode(raw)
      check raw == decode(b32)
  BASE32 "", ""
  BASE32 "f", "MY======"
  BASE32 "fo", "MZXQ===="
  BASE32 "foo", "MZXW6==="
  BASE32 "foob", "MZXW6YQ="
  BASE32 "fooba", "MZXW6YTB"
  BASE32 "foobar", "MZXW6YTBOI======"

suite "Low/High":
  proc BASE32(raw, b32: string) =
    test b32:
      check b32 == encode(raw)
      check raw == decode(b32)
  BASE32 "\0", "AA======"
  BASE32 "\0\0", "AAAA===="
  BASE32 "\0\0\0", "AAAAA==="
  BASE32 "\0\0\0\0", "AAAAAAA="
  BASE32 "\0\0\0\0\0",  "AAAAAAAA"
  BASE32 "\xff", "74======"
  BASE32 "\xff\xff", "777Q===="
  BASE32 "\xff\xff\xff", "77776==="
  BASE32 "\xff\xff\xff\xff", "777777Y="
  BASE32 "\xff\xff\xff\xff\xff", "77777777"
