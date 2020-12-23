#!/usr/bin/env python3

import sys
import datetime
import os

def ultraprint(xxxx, yyy):
    print(xxxx)
    print(xxxx, file=yyy)
def L_part(align, logfileL):
    Lname = str(name+"_remain_") # имя остатка
    L = align[n1+N1:len(align)-(n2+N2)] # остаток
    print(Lname, file=logfileL)
    print(L, file=logfileL)
def n_part(align, logfilen):
    part_n1 = align[:n1] # первый удаляемый участок
    n1name = str(name+"_forward_edge_")
    part_n2 = align[len(align)-n2:] # второй удаляемый участок
    n2name = str(name+"_revers_edge_")
    print(n1name, file = logfilen)
    print(part_n1, file = logfilen)
    print(n2name, file = logfilen)
    print(part_n2, file = logfilen)
def N_part():
    ultraprint(">_start_"+name, myfile)
    ultraprint(N1_reg, myfile)
    ultraprint(">_finish_"+name, myfile)
    ultraprint(N2_reg, myfile)

print("Этот скрипт обрезает все контиги в последовательности по следующей схеме:")
print()
print("-------------------------------------------------> контиг")
print("|__n1__|___N1___|-------L-------|___N2___|__n1__| обрезка контига")
print()
print("где n - число отбракованных нуклеотидов")
print("    N - число нуклеотидов, входящих в концевые участки контига, которые и необходимо получить")
print()
print("Программа принимает как сборки в формате fasta, так и простые файлы в формате fasta.")
print("Не все контиги полезны - минимальная длина рассматриваемого контига задаётся параметром G. В режиме 'записи вообще всего' в отдельные файлы будут записываться оставшиеся после кромсания куски. Отдельно будет вестись запись лог-файла")
print()
print()
cyfra = False


while cyfra == False:
    first_file = input("Введите адрес и имя последовательности: ")
    if first_file == "exit":
        sys.exit()
    try:
        with open(first_file, 'r') as f:
            text = f.read()
            cyfra = True
    except:
        print("Не удалось найти файл")
        print()

n1 = int(input("Введите параметр n1: "))
N1 = int(input("Введите параметр N1: "))
n2 = int(input("Введите параметр n2: "))
N2 = int(input("Введите параметр N2: "))
try:
    G = int(input("Введите параметр G: "))
except:
    G = 0

print()
print()

first_time = True # Страховка на случай перезаписи файла
bb = input("Желаете включить режим записи вообще всего? (yes): ")
ls_yes = ['yes', 'y', '', 'Да', 'Yes', 'Y', 'да', 'д', 'Д', 'ну конечно!']
print(bb)
if bb in ls_yes:
    big_boss = True
else:
    big_boss = False

number_start = 0
number_fin = 0

nodes=text.split('>') # Разделяем всю сборку на отдельные элементы по признаку наличия '>'
for i in nodes:
    if i != "": # избавляемся от пустых мест в списке
        number_start += 1
        seq = str('>'+i) # Каждый элемент - целая последовательность вместе с именем
        ind = seq.find('\n') # Определяем, где лежит граница между последовательностью и именем
        name = seq[:ind].replace('\n', '') # Отделяем имя, удаляя возможные абзацы
        align = seq[ind:].replace('\n', '') # Отделяем последовательность, удаляя возможные абзацы
        if len(align) >= G: # избавляемся от контигов, меньших чем G
            N1_reg = align[n1:n1+N1] # первый необходимый участок
            N2_reg = align[(len(align)-(N2+n2)):(len(align)-n2)] # второй необходимый участок
            if first_time == True: # первая новая запись
                with open(first_file+"_neededends", 'w') as myfile:
                    N_part() # записывает все последовательности концов в один файл
                    if big_boss == True:
                        with open(first_file+"_remains", 'w') as myfile2:
                            L_part(align, myfile2) # записывает остатки
                        with open(first_file+"_edges", 'w') as myfile3:
                            n_part(align, myfile3) # записывает отброшенные участки
            if first_time == False: # последующие добавляются в конец файла
                with open(first_file+"_neededends", 'a') as myfile:
                    N_part()
                    if big_boss == True:
                        with open(first_file+"_remains", 'a') as myfile2:
                            L_part(align, myfile2) # дописывает остатки
                        with open(first_file+"_edges", 'a') as myfile3:
                            n_part(align, myfile3) # дописывает отброшенные участки
            first_time = False
            number_fin += 1
print()
print()
if big_boss == True:
    with open(first_file+"_logfile", 'a') as logfile:
        ultraprint("*******************************************", logfile)
        ultraprint(datetime.datetime.now().strftime("%Y-%m-%d, %H:%M:%S"), logfile)
        ultraprint("Результат запуска скрипта №5 (Не знаю, почему так)", logfile)
        ultraprint("Заданные параметры:", logfile)
        ultraprint("n1: "+str(n1), logfile)
        ultraprint("n2: "+str(n2), logfile)
        ultraprint("N1: "+str(N1), logfile)
        ultraprint("N2: "+str(N1), logfile)
        ultraprint("G: "+str(G), logfile)
        ultraprint('\n', logfile)
        ultraprint("Получено контигов: "+str(number_start), logfile)
        ultraprint("Обработано контигов: "+str(number_fin), logfile)
        ultraprint('\n', logfile)
        ultraprint("Записан файл (N): "+os.getcwd()+"/"+first_file+"_neededends", logfile)
        ultraprint("Записан файл (L): "+os.getcwd()+"/"+first_file+"_remains", logfile)
        ultraprint("Записан файл (n): "+os.getcwd()+"/"+first_file+"_edges", logfile)
        ultraprint("Записан логфайл: "+os.getcwd()+"/"+first_file+"_logfile", logfile)
        ultraprint('Успешно.', logfile)
        ultraprint("*******************************************", logfile)
        ultraprint('\n', logfile)
