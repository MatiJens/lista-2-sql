CREATE DATABASE IF NOT EXISTS sprzedaz;

USE sprzedaz;

DROP TABLE IF EXISTS zamowienia;
DROP TABLE IF EXISTS magazyn;

CREATE TABLE IF NOT EXISTS magazyn (
	towar_id INT PRIMARY KEY auto_increment, # Automatyczne zwiększanie ID o 1
    nazwa VARCHAR(100) NOT NULL,
    stan INT NOT NULL,
    cena_jednostkowa DECIMAL(10, 2) # Liczba zmiennoprzecinkowa maks. 10 cyfr, z czego 2 po przecinku
    );
    
CREATE TABLE IF NOT EXISTS zamowienia (
	zamowienia_id INT PRIMARY KEY auto_increment, # Automatyczne zwiększanie ID o 1
    odbiorca VARCHAR(100) NOT NULL,
    towar INT,
    ilosc INT NOT NULL,
    
    FOREIGN KEY (towar) REFERENCES magazyn(towar_id)
    );

INSERT INTO magazyn
	(nazwa, stan, cena_jednostkowa)
VALUES
	('rower', 5, 1999.99),
    ('wrotki', 10, 200.00),
    ('rolki', 20, 599.00),
    ('hulajnoga', 2, 99.99);
    
INSERT INTO zamowienia
	(odbiorca, towar, ilosc)
VALUES
	('Tomek', 2, 3),
    ('Maciek', 1, 1),
    ('Beata', 4, 2),
    ('Robert', 1, 1);
    
SELECT * FROM magazyn;
SELECT * FROM zamowienia;