import std/strutils, std/strformat
type Fruit = object
  name: string
  color: string

proc `$`(self: Fruit): string =
  &"Fruit({self.name}, {self.color})"

let apple = Fruit(name: "apple", color: "red")

echo apple

echo $apple

echo "hello " & $apple

echo "hello $1" % [$apple]

echo &"hello {apple}"
echo &"hello {$apple}"
