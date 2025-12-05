
rangeList=[0,100]
print(f" Please choose number between 0 and {rangeList[1]}")

while(rangeList[0] != rangeList[1]):
    questionNum = (rangeList[0]+rangeList[1]) // 2
    userInput = ''
    while(userInput not in ('y', 'n')):
       userInput = input(f" Is your number larger than {questionNum} y/n \n").lower()


    if userInput=='y':
        rangeList=[questionNum + 1, rangeList[1]]
    else:
        rangeList=[rangeList[0], questionNum]
 
print(f"Your number is {rangeList[0]}")  
    
