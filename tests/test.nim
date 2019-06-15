import base32

var e = encode("Hello")
echo e
assert e == "JBSWY3DP"

var d = decode(e)
echo d
assert d == "Hello"

var vietnam = "Socialist Republic of Vietnam"
e = encode(vietnam)
echo e
assert e == "KNXWG2LBNRUXG5BAKJSXA5LCNRUWGIDPMYQFM2LFORXGC3I="

d = decode(e)
echo vietnam
echo d
assert d == vietnam
