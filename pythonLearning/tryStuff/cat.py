from animal import Animal

class Cat(Animal):

    def __init__(self, breed, name, age, parent):
        self.breed = breed
        self.name = name
        self.age = age
        self.__parent = parent


    def getParent(self):
        return self.__parent    
    

    def speak(self):
        return f'{self.name} says Myauu Myauu'