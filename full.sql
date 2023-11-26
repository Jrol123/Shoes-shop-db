CREATE TABLE IF NOT EXISTS Clients
(
    ID             INTEGER PRIMARY KEY AUTOINCREMENT,
    'First name'   varchar(150),
    'Second name'  varchar(200),
    'Birth date'   DATE,
    'Address'      TEXT,
    'Shop cart id' INTEGER NOT NULL,
    FOREIGN KEY ('Shop cart id') REFERENCES 'Shop carts' (ID)
);

CREATE TABLE IF NOT EXISTS Cards
(
    ID          INTEGER PRIMARY KEY AUTOINCREMENT,
    'ID client' INTEGER,
    Number      varchar(30),
    Date        DATE,
    FOREIGN KEY ('ID client') REFERENCES Clients (ID)
);
-- Если не будет добавлен доп. функционал, то можно убрать эту таблицу и связывать товары напрямую с человеком.
CREATE TABLE IF NOT EXISTS 'Shop carts'
(
    ID          INTEGER PRIMARY KEY AUTOINCREMENT,
    'ID client' INTEGER,
    -- Единоразовый подсчёт суммы покупки при добавлении новго товара
    'Total sum' INTEGER,
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

CREATE TABLE Statuses
(
    ID     INTEGER PRIMARY KEY AUTOINCREMENT,
    Status TEXT UNIQUE
);
-- Добавить таблицу скидок (?)
CREATE TABLE IF NOT EXISTS Items
(
    ID                  INTEGER PRIMARY KEY AUTOINCREMENT,
    'ID company'        INTEGER,
    Description         TEXT,
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
    Description TEXT
);

DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS Cards;
DROP TABLE IF EXISTS 'Shop carts';
DROP TABLE IF EXISTS 'Items in cart';
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS 'Tags to items';
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Companies;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS 'Items in order';
DROP TABLE IF EXISTS Statuses;
