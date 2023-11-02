proc fibonacci(n: int): int =
  if n < 2:
    result = n
  else:
    result = fibonacci(n - 1) + (n - 2).fibonacci
# operators
proc `$`(a: array[2, array[2, int]]): string =
  result = ""
  for v in a:
    for vx in v:
      result.add($vx & ", ")
    result.add("\n")

echo([1,2], [3,4])

proc `^&*^@%`(a,b:string): string =
  result = a[0] & b[high(b)]

assert("foo" ^&*^@% "bar" == "fr")
# generic
proc `+`(a, b:string): string =
  a & b
proc `*`[T](a: T, b: int): T =
  result = default(T)
  for i in 0..b-1:
    result = result + a
assert("a" * 10 == "aaaaaaaaaa")
