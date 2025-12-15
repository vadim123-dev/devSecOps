import random

def get_encrypt_key():
    alphabet_str = 'abcdefghijklmnopqrstuvwxyz'
    alphabet_list = list(alphabet_str)
    length = len(alphabet_list)
    rand_places = random.sample(range(length),length)
    key = {}
    for num in range(length):
        key[alphabet_list[num]] = alphabet_list[rand_places[num]]
    
    return key
        
def get_decrypt_key(encrypt_key):
    decrypt_key = {}
    for x in encrypt_key:
        decrypt_key[encrypt_key[x]] = x
    return decrypt_key

def encrypt_decrypt_txt(txt,key):
    txt_list = list(txt)
    encrypted_txt = ''
    for l in txt_list:
        encrypted_txt += key[l]

    return encrypted_txt

def test_encryption():
    encrypt_key = get_encrypt_key()
    decrypt_key = get_decrypt_key(encrypt_key)
    encrypted_txt = encrypt_decrypt_txt('california',encrypt_key)
    print(f"encrypted_txt = {encrypted_txt}")
    decrypted_text = encrypt_decrypt_txt(encrypted_txt, decrypt_key)
    print(f"decrypted_text = {decrypted_text}")

test_encryption()




