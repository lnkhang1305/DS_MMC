import sys
import os 
import pandas as pd
import numpy as np
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(SCRIPT_DIR))


from mypackage.Path import *


def open_file():
    """Remember to close"""
    while 1:
        filename = input('Nhap ten file: ')
        match filename:
            case 'class1.txt':
                fi = open(PATH1,'r')
                print(f'Successfully opened {filename}')
                break
            case 'class2.txt':
                fi = open(PATH2,'r')
                print(f'Successfully opened {filename}')
                break
            case 'class3.txt':
                fi = open(PATH3,'r')
                print(f'Successfully opened {filename}')
                break
            case 'class4.txt':
                fi = open(PATH4,'r')
                print(f'Successfully opened {filename}')
                break
            case 'class5.txt':
                fi = open(PATH5,'r')
                print(f'Successfully opened {filename}')
                break
            case 'class6.txt':
                fi = open(PATH6,'r')
                print(f'Successfully opened {filename}')
                break
            case 'class7.txt':
                fi = open(PATH7,'r')
                print(f'Successfully opened {filename}')
                break
            case 'class8.txt':
                fi = open(PATH8,'r')
                print(f'Successfully opened {filename}')
                break
            case _:
                print("Sorry, I can't find this filename")
    return fi, filename
def check_ID(string):
    if len(string) < 9:
        return False
    if string[0] != 'N':
        return False
    for i in range(1,len(string)):
        if not string[i].isdigit():
            return False
    return True
def check_answer(string):
    if string != string:
        return True
    if string.isdigit() or '-' in string:
        return False
    return True
def analyzing(f):
    rows = []
    pre_data = f.readlines()
    for row in pre_data:
        lst_row = [l.strip() for l in row.split(',')]
        if len(lst_row) >= 26:
            rows.append(lst_row[:25] + ['-'.join(lst_row[25:])])
        else:
            rows.append(lst_row[:26] + [0 for i in range(26 - len(lst_row))])
    df = pd.DataFrame(rows)
    df.to_csv('temp.txt',index=False)
    data = pd.read_csv('temp.txt')
    count_error = 0
    list_error = []
    flag = False
    for i in range(len(data)):
        if not(check_ID(data.iloc[i,0])) and not(check_answer(data.iloc[i,25])):
            flag = True
            print('Invalid line of data: does not contain exactly 26 values and N# is invalid:')
            print(pre_data[i])
            count_error += 1
            list_error.append(i)
        elif not(check_ID(data.iloc[i,0])):
            flag = True
            print('Invalid line of data: N# is invalid:')
            print(pre_data[i])
            count_error += 1
            list_error.append(i)
        elif not(check_answer(data.iloc[i,25])):
            flag = True
            print('Invalid line of data: does not contain exactly 26 values:')
            print(pre_data[i])
            count_error += 1
            list_error.append(i)
    return len(data) - count_error, count_error, list_error, data
def statis(data, list_invalid, answer_key):
    grades = {}
    question_skip = [0] * 26
    question_wrong = [0] * 26
    rate_skip = [0] * 26
    rate_wrong = [0] *26
    for i in range(len(data)):
        sum_point = 0
        if i in list_invalid:
            continue
        stu_np = data.iloc[i,1:].to_numpy()
        for q in range(len(stu_np)):
            if stu_np[q] != stu_np[q]:
                question_skip[q + 1] += 1
            elif stu_np[q] != answer_key[q]:
                sum_point -= 1
                question_wrong[q + 1] += 1
            elif stu_np[q] == answer_key[q]:
                sum_point += 4
        grades[data.iloc[i,0]] = sum_point
    scores = np.array(list(grades.values()))
    for i in range(1,26):
        rate_skip[i] = round(question_skip[i] / (len(data) - len(list_invalid)),2)
        rate_wrong[i] = round(question_wrong[i] /  (len(data) - len(list_invalid)),2)
    max_skip = max(rate_skip)
    max_wrong = max(rate_wrong)
    skip = [i for i in range(1,26) if rate_skip[i] == max_skip]
    wrong = [i for i in range(1,26) if rate_wrong[i] == max_wrong]
    print(f'Total student of high scores: {len(scores[scores > 80])}')
    print(f'Mean (average) score: {np.mean(scores)}')
    print(f'Highest score: {np.max(scores)}')
    print(f'Lowest score: {np.min(scores)}')
    print(f'Range of scores: {np.max(scores) - np.max(scores)}')
    print(f'Median score: {np.median(scores)}')
    print('\n')
    print('Question that most people skip:',end='')
    for ques in skip:
        print(f'{ques} - {question_skip[ques]} - {max_skip}',end=', ')
    print('\n')
    print('Question that most people answer incorrectly:',end='')
    for ques in wrong:
        print(f'{ques} - {question_wrong[ques]} - {max_wrong}',end=', ')
    return grades
def main():
    f, filename = open_file()
    
    # Analyzing
    print('**** ANALYZING ****')
    num_valid, num_invalid, list_invalid, data = analyzing(f)

    #Report
    print('**** REPORT ****')
    print(f'Total valid lines of data: {num_valid}')
    print(f'Total invalid lines of data: {num_invalid}')
    print('\n')
    #Statis 
    answer_key = "B,A,D,D,C,B,D,A,C,C,D,B,A,B,A,C,B,D,A,C,A,A,B,D,D"
    grades = statis(data,list_invalid,np.array(answer_key.split(',')))
    df = pd.DataFrame(grades.items())
    fileout = filename[:-4] + '_grades.txt'
    df.to_csv(fileout,index=False,header=False)
    f.close()
if __name__ == "__main__":
    main()
