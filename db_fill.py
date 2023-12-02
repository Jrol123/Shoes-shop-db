import sqlite3, random, datetime, hashlib
from random_username.generate import generate_username

from faker import Faker

fake = Faker(['ru_RU', 'en_US'])
max_count = 10 ** 1

connection = sqlite3.connect('identifier.sqlite')
cursor = connection.cursor()

"""Создание записей для аккаунтов"""
m = hashlib.sha256()
for test_index in range(1, max_count + 1):
    m.update(b"{fake.password()}")

    cursor.execute(
        'INSERT INTO Clients ("login", "password",'
        ' "First name", "Second name", "Phone number", "Birth date", Address, "Shop cart id")'
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        (generate_username()[0], m.hexdigest(), fake.first_name(), fake.last_name(), fake.phone_number(), fake.date(),
         fake.address(), test_index))

    cursor.execute('INSERT INTO "Shop carts" ("ID client", "Total sum")'
                   'VALUES (?, ?)',
                   (test_index, 0))

    cursor.execute('INSERT INTO Cards ("ID client", Number, Date, "Security code")'
                   'VALUES (?, ?, ?, ?)',
                   (test_index, fake.credit_card_number(), fake.credit_card_expire(), fake.credit_card_security_code()))

"""Создание записей о продаже"""
for test_index in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Sales ("ID item", "ID client", "ID order", "Quantity", "Date")'
        'VALUES (?, ?, ?, ?, ?)',
        (random.randrange(1, max_count + 1),
         random.randrange(1, max_count + 1),
         random.randrange(1, max_count + 1),
         random.randrange(1, 365 + 1),
         fake.date_between(start_date=datetime.date(year=1941, month=6, day=22),
                           end_date=datetime.date(year=1988, month=11, day=16))))

"""Создание сведений о компании"""
for test_index in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Companies (Name, Description)'
        'VALUES (?, ?)',
        (fake.company(), fake.catch_phrase())
    )

"""Создание сведений о продуктах"""
for test_index in range(1, max_count + 1):
    size = random.randrange(20, 80 - 2 + 1)
    cursor.execute(
        'INSERT INTO Items ("ID company", Name, Description, Color, Size, Material, Price, "Quantity in stock")'
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        (random.randrange(1, max_count + 1), fake.first_name(), fake.paragraph(nb_sentences=6), fake.color(), f'{size}-{size + 2}', fake.catch_phrase(), random.randrange(10 ** 3, 10**4), random.randrange(0, 10**3))
    )

    cursor.execute(
        'INSERT INTO Orders ("ID client", Status)'
        'VALUES (?, ?)',
        (random.randrange(1, max_count + 1), random.randrange(1, 7 + 1))
    )

    cursor.execute(
        'INSERT INTO "Items in order" ("Item id", "Shop cart id", Quantity)'
        'VALUES (?, ? , ?)',
        (random.randrange(1, max_count + 1), random.randrange(1, max_count + 1), random.randrange(1, 40 + 1))
    )

    cursor.execute('SELECT COUNT(*) FROM Tags')
    count_tags = cursor.fetchone()[0]
    cursor.execute(
        'INSERT INTO "Tags to items" ("ID item", "ID tag")'
        'VALUES (?, ?)',
        (random.randrange(1, max_count + 1), random.randrange(1, count_tags + 1))
    )

connection.commit()
connection.close()
