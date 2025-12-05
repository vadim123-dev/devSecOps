lst=[-3,8,3,12,13,4,6,8,10,11,33,6,0,1]

if lst[0] > lst[1]:
    lrg = lst[0]
    scnd = lst[1]
else:
    lrg = lst[1] 
    scnd = lst[0]

for num in lst:
    if num > lrg:
        scnd = lrg
        lrg = num
    elif num > scnd:















        
        scnd = num  

print(lrg)
print(scnd)            
