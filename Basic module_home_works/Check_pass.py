#@title Проверка пароля
pas = input()
count_len = 1 #'добавьте 12 - len(pas) символов'
count_up = 1 #'добавьте заглавную букву'
count_low = 1 #'добавьте строчную букву'
count_dig = 1 #'добавьте цифру'
count_spec = 1 #'добавьте спецсимвол'
blok_char = 0 # 'запрещенные символы'
# Проверка на запрещенные символы
delimiter = ','
for i in pas:
    if i not in (delimiter.join('1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()-+')):    
        blok_char = 1
        break
if blok_char == 1:
    print('Ошибка. Запрещенный спецсимвол')
else:
    # Проверка длинны
    if len(pas) >= 12:
        count_len = 0
    # Проверка на спецсимволы
    for i in pas:
        if count_spec == 1:
            for y in '!@#$%^&*()-+':
                if i != y:
                    count_spec = 1
                else:
                    count_spec = 0
                    break
    # Проверка на строчные буквы
    for i in pas:
        if count_low == 1:
            for y in 'abcdefghijklmnopqrstuvwxyz':
                if i != y:
                    count_low = 1
                else:
                    count_low = 0
                    break
    # Проверка на заглавные буквы
    for i in pas:
        if count_up == 1:
            for y in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ':
                if i != y:
                    count_up = 1
                else:
                    count_up = 0
                    break
    # Проверка на цифры
    for i in pas:
        if count_dig == 1:
            for y in '1234567890':
                if i != y:
                    count_dig = 1
                else:
                    count_dig = 0
                    break
    print(count_len, count_up, count_low, count_dig, count_spec)
    if 1 in (count_len, count_up, count_low, count_dig, count_spec):
        weak_pas = 'Слабый пароль. Рекомендации:'
        if count_len == 1:
            weak_pas += ', добавьте '+ str(12 - len(pas)) + ' символов.'
        elif count_up == 1:
            weak_pas += ', добавьте заглавную букву.'  
        elif count_low == 1:
            weak_pas += ', добавьте строчную букву.' 
        elif count_dig == 1:
            weak_pas += ', добавьте цифру.'  
        elif count_spec == 1:
            weak_pas += ', добавьте спецсимвол.' 
        print((weak_pas.replace(':,',':')).replace('.,',',') )

    else:
        print('Сильный пароль')
