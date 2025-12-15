
for col in range(1, 11):
    for row in range(1, 11):
        num_str = str(col * row).rjust(4,' ')
        num_str += '|'
        print(num_str + "  ", end=' ')
    print()    
  
     