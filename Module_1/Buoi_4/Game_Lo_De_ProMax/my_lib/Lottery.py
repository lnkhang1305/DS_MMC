### Lottery
import random
from my_lib.ProcessAccount import *
from my_lib.Path import *
from datetime import datetime

def random_string_number():
  rs = ''
  for i in range(5):
    rs += str(random.randint(0,9))
  return rs
def random_prize():
  dict_prize = {}
  prize_order = 1
  for i in range(7):
    dict_prize[f'Giai {prize_order}'] = random_string_number()
    prize_order += 1
  return dict_prize
def print_prize():
  prizes = random_prize()
  for prize, value in prizes.items():
    print(f'{prize}: {value}')
  return prizes
def input_number():
  while True:
    number = input('Nhap so lo (10 -> 99): ').split(",")
    for num in number:
      if not num.isdigit() or len(num) != 2:
        print('Nhap sai dinh dang. Vui long nhap lai!')
        continue
    break
  return number
def bet_money(MONEY):
  print('Tien hien tai: ', MONEY)
  while True:
    bet = input('Nhap so tien muon cuoc (< tien hien tai): ')
    if bet.isdigit() and int(bet) > 0 and int(bet) < MONEY:
      return int(bet)
    else:
      print('Sai dinh dang. Moi nhap lai!')
      continue
def save_info(username, numbers, bet, prizes,  win_money, lost_money):
    try:
        _time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        info = f"{_time},{username},{','.join(numbers)},{bet}," \
                    f"{','.join(prizes.values())},{win_money},{lost_money}\n"

        write_file(info, DATA_LOT, "a")
        print("Thông tin về lần chơi lô đã được lưu.")



    except Exception as e:
        print(f"Có lỗi xảy ra khi lưu thông tin: {e}")
def update_acc(username, sum_money):
    try:
        data_acc = read_file(DATA_ACC, "r")
        if data_acc:
            for i, acc in enumerate(data_acc):
                if acc[0] == username:
                    data_acc[i][2] = str(sum_money)  
                    write_file([','.join(acc) + '\n' for acc in data_acc], DATA_ACC, "w")
                    return
    except Exception as e:
        print(f"Có lỗi xảy ra khi cập nhật thông tin tài khoản: {e}")