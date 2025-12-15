# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34...
# using tuple

# one, two = two, one + two 

one, two = 0, 1

for count in range(10):
    print(one)
    one, two = two, one + two


