#!/usr/bin/python
number = 0

while number <= 100:
    if number % 7 == 0 or "7" in str(number) :
        print('boom')
    else:
        print(number)
    number+=1

