
prefix = '==> '
command = ''

while(command := input('myCli> ').strip('- ').lower()) != 'quit':
     outputStr = prefix + command + ' is a nice command'
     print(outputStr)

print(prefix + 'got quit command, goodbye.')

