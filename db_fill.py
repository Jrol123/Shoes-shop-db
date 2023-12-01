import sqlite3, names, random, datetime

from faker import Faker

fake = Faker(['ru_RU', 'en_US'])
max_count = 10 ** 1

connection = sqlite3.connect('identifier.sqlite')
cursor = connection.cursor()

"""Создание записей для аккаунтов"""
for test_index in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Clients ("login", "password",'
        ' "First name", "Second name", "Birth date", Address, "Shop cart id")'
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        (names.get_full_name(), hash(test_index), names.get_first_name(), names.get_last_name(), fake.date(),
         fake.address(), test_index))

    cursor.execute('INSERT INTO "Shop carts" ("ID client", "Total sum")'
                   'VALUES (?, ?)',
                   (test_index, 0))

connection.commit()
connection.close()