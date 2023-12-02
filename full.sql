CREATE TABLE IF NOT EXISTS Clients
(
    ID             INTEGER PRIMARY KEY AUTOINCREMENT,
    login          varchar(50),
    password       varchar(50),
    'First name'   varchar(150),
    'Second name'  varchar(200),
    'Phone number' varchar(20),
    'Birth date'   DATE,
    'Address'      TEXT,
    'Shop cart id' INTEGER NOT NULL,
    FOREIGN KEY ('Shop cart id') REFERENCES 'Shop carts' (ID)
);

CREATE TABLE IF NOT EXISTS Cards
(
    ID              INTEGER PRIMARY KEY AUTOINCREMENT,
    'ID client'     INTEGER,
    Number          varchar(30),
    Date            DATE,
    'Security code' INTEGER(6),
    FOREIGN KEY ('ID client') REFERENCES Clients (ID)
);
-- Если не будет добавлен доп. функционал, то можно убрать эту таблицу и связывать товары напрямую с человеком.
CREATE TABLE IF NOT EXISTS 'Shop carts'
(
    ID          INTEGER PRIMARY KEY AUTOINCREMENT,
    'ID client' INTEGER,
    -- Единоразовый подсчёт суммы покупки при добавлении новго товара
    'Total sum' INTEGER DEFAULT 0,
    FOREIGN KEY ('ID client') REFERENCES Clients (ID)
);

CREATE TABLE IF NOT EXISTS 'Items in cart'
(
    ID             INTEGER PRIMARY KEY AUTOINCREMENT,
    'Item id'      INTEGER NOT NULL,
    'Shop cart id' INTEGER NOT NULL,
    Quantity       INTEGER NOT NULL,
    FOREIGN KEY ('Shop cart id') REFERENCES 'Shop carts' (ID),
    FOREIGN KEY ('Item id') REFERENCES Items (ID)
);

-- Заказ
CREATE TABLE IF NOT EXISTS Orders
(
    ID          INTEGER PRIMARY KEY AUTOINCREMENT,
    'ID client' INTEGER,
    Status      INTEGER DEFAULT 1,
    FOREIGN KEY ('ID client') REFERENCES Clients (ID),
    FOREIGN KEY (Status) REFERENCES Statuses (ID)
);

CREATE TABLE IF NOT EXISTS 'Items in order'
(
    ID             INTEGER PRIMARY KEY AUTOINCREMENT,
    'Item id'      INTEGER NOT NULL,
    'Shop cart id' INTEGER NOT NULL,
    Quantity       INTEGER NOT NULL,
    FOREIGN KEY ('Shop cart id') REFERENCES Orders (ID),
    FOREIGN KEY ('Item id') REFERENCES Items (ID)
);

CREATE TABLE IF NOT EXISTS Statuses
(
    ID     INTEGER PRIMARY KEY AUTOINCREMENT,
    Status TEXT UNIQUE
);
-- Добавить таблицу скидок (?)
CREATE TABLE IF NOT EXISTS Items
(
    ID                  INTEGER PRIMARY KEY AUTOINCREMENT,
    'ID company'        INTEGER,
    Name                varchar(100),
    Description         TEXT,
    Color               TEXT,
    --- 42-44
    Size                varchar(5),
    Material            varchar(50),
    Price               INTEGER,
    'Quantity in stock' INTEGER,
    FOREIGN KEY ('ID company') REFERENCES Companies (ID)
);

CREATE TABLE IF NOT EXISTS Sales
(
    ID          INTEGER PRIMARY KEY AUTOINCREMENT,
    'ID item'   INTEGER NOT NULL,
    'ID client' INTEGER NOT NULL,
    'ID order'  INTEGER NOT NULL,
    Quantity    INTEGER NOT NULL,
    Date        DATE    NOT NULL,
    FOREIGN KEY ('ID item') REFERENCES Items (ID),
    FOREIGN KEY ('ID client') REFERENCES Clients (ID),
    FOREIGN KEY ('ID order') REFERENCES Orders (ID)
);

CREATE TABLE IF NOT EXISTS 'Tags to items'
(
    'ID item' INTEGER NOT NULL,
    'ID tag'  INTEGER NOT NULL,
    FOREIGN KEY ('ID item') REFERENCES Items (ID),
    FOREIGN KEY ('ID tag') REFERENCES Tags (ID)
);

CREATE TABLE IF NOT EXISTS Tags
(
    ID          INTEGER PRIMARY KEY AUTOINCREMENT,
    Description TEXT
);

CREATE TABLE IF NOT EXISTS Companies
(
    ID          INTEGER PRIMARY KEY AUTOINCREMENT,
    Name        VARCHAR(200),
    Description TEXT
);

INSERT INTO Tags (Description) VALUES ('Официальные');
INSERT INTO Tags (Description) VALUES ('Пляжные');
INSERT INTO Tags (Description) VALUES ('Купальные');
INSERT INTO Tags (Description) VALUES ('Горные');

INSERT INTO Statuses (Status) VALUES ('To do_No pay');
INSERT INTO Statuses (Status) VALUES ('To do_Yes pay');
INSERT INTO Statuses (Status) VALUES ('In progress_No pay');
INSERT INTO Statuses (Status) VALUES ('In progress_Yes pay');
INSERT INTO Statuses (Status) VALUES ('Await_No pay');
INSERT INTO Statuses (Status) VALUES ('Await_Yes pay');
INSERT INTO Statuses (Status) VALUES ('Done');


DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS Cards;
DROP TABLE IF EXISTS 'Shop carts';
DROP TABLE IF EXISTS 'Items in cart';
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS 'Tags to items';
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Companies;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS 'Items in order';

DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Statuses;
