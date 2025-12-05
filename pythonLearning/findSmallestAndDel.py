lst1=[1,-9,20,10,-8,-3,-7,30,5,6,7,11,-2,-9]


while(len(lst1))>0:
    smallest=lst1[0]
    numIndex=0
    for index in range(len(lst1)):
        if(smallest>lst1[index]):
            smallest=lst1[index]
            numIndex=index

   
    print(smallest)
    del lst1[numIndex]
                 