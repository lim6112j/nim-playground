# type Animal = object
#   name: string
#   age: int
#
# proc speak(self:Animal, msg: string) =
#   echo self.name & " saays:" & msg
#
# var sparky = Animal(name: "Sparky", age: 10)
#
# sparky.speak("Hi")
# speak(sparky, "Hi")
#
# proc double(num: int):int =
#   return num*2
#
# echo double(10)
#
# echo 10.double()
#
# echo 10.double
type Animal = ref object of RootObj
  name: string
  age: int
method vocalize(self: Animal): string {.base.} = "..."
method ageHumanYrs(self: Animal): int {.base.} = self.age

type Dog = ref object of Animal
method vocalize(self: Dog): string = "woof"
method ageHumanYrs(self: Dog): int = self.age * 7

type Cat = ref object of Animal
method vocalize(self: Cat): string = "meow"

var animals: seq[Animal] = @[]
animals.add(Dog(name: "Sparky", age: 10))
animals.add(Cat(name: "Mitten", age: 10))

for a in animals:
  echo a.vocalize()
  echo a.ageHumanYrs()
