###  ProccessAccount
from my_lib.ProccessFile import *
from my_lib.Path import *
def create_acc(username, password, money):
  data = read_file(DATA_ACC, 'r')
  account = []
  for user in data:
    if username == user[0]:
      print('Tai khoan da ton tai')
      return
  account = f'{username},{password},{money}\n'
  write_file(account, DATA_ACC, 'a')
  print(f'Tao tai khoan \'{username}\' thanh cong')
def delete_acc(username):
  if username == 'admin':
    print('Khong the xoa tai khoan admin!')
    return
  data = read_file(DATA_ACC,'r')
  flag = 0 
  for user in data:
    if username == user[0]:
      data.remove(user)
      flag = 1
      print('Xoa tai khoan thanh cong!')
      break
  if flag == 0:
    print('Khong ton tai tai khoan!')
  open(DATA_ACC,'w').close()
  for user in data:
    user_info = f'{user[0]},{user[1]},{user[2]}\n'
    write_file(user_info,DATA_ACC,'a')

def change_password(username, old_password, new_password):
  data = read_file(DATA_ACC,'r')
  for user in data:
    if user[0] == username and user[1] == old_password:
      user[1] = new_password
      print('Nap tien thanh cong')
      write_file_data(data,DATA_ACC)
      return
  print('Khong ton tai tai khoan hoac sai mat khau cu!')
def recharge_money(username, money):
  data = read_file(DATA_ACC,'r')
  for user in data:
    if user[0] == username :
      user[2] = str(int(user[2]) + int(money))
      open(DATA_ACC,'w').close()
      for user in data:
        user_info = f'{user[0]},{user[1]},{user[2]}\n'
        write_file(user_info,DATA_ACC,'a')
      return
  print('Khong ton tai tai khoan hoac sai mat khau cu!')
def check_sign_in(username, password):
  global sign_in_status
  data = read_file(DATA_ACC,'r')
  for user in data:
    if user[0] == username and user[1] == password:
      sign_in_status = True
      return True
  return False
def take_info(username):
  data = read_file(DATA_ACC,'r')
  for user in data:
    if user[0] == username:
      return user[0],user[1],user[2]
def check_admin(username,password):
  if username == 'admin' and password == 'admin':
    return True
  return False
