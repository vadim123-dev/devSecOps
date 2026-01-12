import re

def get_clean_string(str):
    return re.sub(r'[^a-zA-Z]', ' ', str)

def convert_to_lower(str):
    return str.lower()

def split_to_words(str):
    return str.split()

def get_most_common_word(arr):
    word_dict = {}
    most_common_word_dict = {'word':arr[0],'count':1}
    for current_word in arr:
        if(current_word in word_dict):
            word_in_dict = word_dict[current_word]
            word_dict[current_word] += 1
            if(word_in_dict > most_common_word_dict['count']):
                most_common_word_dict['word'] = current_word
                most_common_word_dict['count'] = word_dict[current_word]
        else:
            word_dict[current_word] = 1
    print(word_dict)
    return most_common_word_dict


def main_test():
    f=open('alice.txt',mode='r',encoding='utf-8')
    str = f.read()
    str = get_clean_string(str)
    str = convert_to_lower(str)
    arr = split_to_words(str)
    #sort the words high to low
#     File "/usr/lib/python3.13/re/__init__.py", line 208, in sub
#     return _compile(pattern, flags).sub(repl, string, count)
#            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^
# TypeError: expected string or bytes-like object, got '_io.TextIOWrapper'
    #get the first 20 words
    most_common_word_dict = get_most_common_word(arr)

    print(most_common_word_dict)


main_test()