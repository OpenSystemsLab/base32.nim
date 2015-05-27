import base32

var e = encode("Hello")
echo e
assert e == "JBSWY3DP"

e = encode("Socialist Republic of Vietnam")
echo e
assert e == "KNXWG2LBNRUXG5BAKJSXA5LCNRUWGIDPMYQFM2LFORXGC3I="
