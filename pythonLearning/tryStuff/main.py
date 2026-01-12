from dog import Dog
from cat import Cat

dog = Dog('Buldog', 'Teya', 3, 'Vadim')
cat = Cat('CittyCat', 'Usya', 3, 'Dasha')

print(f'My first dog is {dog.breed} called: {dog.name} age: '
     f' {dog.age}  Parent {dog.getParent()}')

arr = [dog, cat]

for a in arr:
    print(a.speak())