import std/strformat
type
  Person = object
    name: string
    age: Natural
let people = [
  Person(name: "John", age: 45),
  Person(name: "Kate", age: 30)
]

for person in people:
  echo(fmt"{person.name} is {person.age} years old")

iterator oddNumbers[Idx, T](a: array[Idx, T]): T =
  for x in a:
    if x mod 2 == 1:
        yield x
for odd in oddNumbers([3,6,9,12,15,18]):
  echo odd

import macros, strutils

macro toLookuptable(data: static[string]): untyped =
  result = newTree(nnkBracket)
  for w in data.split(';'):
    result.add newLit(w)

const
  data = "mov;btc;cli;xor"
  opcodes = toLookupTable(data)

for o in opcodes:
  echo o
