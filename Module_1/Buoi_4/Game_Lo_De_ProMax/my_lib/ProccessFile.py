def read_file(filename, mode):
  try:
    with open(filename, mode) as f:
        data = f.readlines()
        data = [line.split(",") for line in data]
        for i in range(len(data)):
          for j in range(len(data[i])):
            data[i][j] = data[i][j].strip()
        return data
  except:
      print('Da xay ra loi')
def write_file(data, filename, mode):
  try:
    with open(filename, mode) as f:
      for line in data:
        f.write(line)
  except:
    print('Da xay ra loi')
def write_file_data(data,filename):
      open(filename,'w').close()
      for user in data:
        user_info = f'{user[0]},{user[1]},{user[2]}\n'
        write_file(user_info,filename,'a')