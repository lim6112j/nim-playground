import macros
macro class*(head, body: untyped): untyped =
  var typeName, baseName: NimNode
  var isExported : bool
  if head.kind == nnkInfix and eqIdent(head[0], "of"):
    typeName = head[1]
    baseName = head[2]
  elif head.kind == nnkInfix and eqIdent(head[0], "*") and head[2].kind == nnkPrefix and eqIdent(head[2][0], "of"):
    typeName = head[1]
    baseName = head[2][1]
    isExported = true
  else:
    error "Invalid node: " & head.lispRepr
  result = newStmtList()

  template typeDecl(a, b): untyped =
    type a = ref object of b
  template typeDeclPub(a, b): untyped =
    type a* = ref object of b
  if isExported:
    result.add getAst(typeDeclPub(typeName, baseName))
  else:
    result.add getAst(typeDecl(typeName, baseName))
  var recList = newNimNode(nnkRecList)
  let ctorName = newIdentNode("new" & $typeName)
  for node in body.children:
    case node.kind:
    of nnkMethodDef, nnkProcDef:
      if node.name.kind != nnkAccQuoted and node.name.basename == ctorName:
        node.params[0] = typeName
      else:
        node.params.insert(1, newIdentDefs(ident("self"), typeName))
      result.add(node)
    of nnkVarSection:
      for n in node.children:
        recList.add(n)
    else:
      result.add(node)
  result[0][0][2][0][2] = recList
  
class Animal of RootObj:
  var name: string
  var age: int
  method vocalize: string {.base.} = "..."
  method age_human_yrs: int {.base.} = self.age
  proc `$`: string = "animal:" & self.name & ":" & $self.age

class Dog of Animal:
  method vocalize : string = "woof"
  method age_human_yrs: int = self.age * 7
  proc `$`: string = "dog:" & self.name & ":" & $self.age
class Cat of Animal:
  method vocalize: string = "meow"
  proc `$`: string = "cat:" & self.name & ":" & $self.age

class Rabbit of Animal:
  proc newRabbit(name: string, age: int) = 
    result = Rabbit(name: name, age: age)
  method vocalize: string = "meep"
  proc `$`: string = "rabbit:" & self.name & ":" & $self.age
  
var animals: seq[Animal] = @[]
animals.add(Dog(name: "Sparky", age: 10))
animals.add(Cat(name: "Mitten", age: 10))

for a in animals:
  echo a.vocalize()
  echo a.age_human_yrs()
  echo a

let r: Animal = newRabbit("Fluffy", 3)
echo r.vocalize()
echo r.age_human_yrs()
echo r
