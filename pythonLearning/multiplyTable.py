
for col in range(1, 11):
    for row in range(1, 11):
        num_str = str(col * row).rjust(3,' ')
        num_str += '|'
        print(num_str + "  ", end=' ')
    print()    
  
     