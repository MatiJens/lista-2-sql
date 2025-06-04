import mysql.connector
import os
from dotenv import load_dotenv

# Połącznie się z serwerem mysql, dane przechowywane sa w pliku .env w celu ich ochrony
cnx = mysql.connector.connect(
    host=os.getenv('host'),
    port=os.getenv('port'),
    user=os.getenv('user'),
    password=os.getenv('password')
)

# Inicjalizacja kursora
cur = cnx.cursor()

# Pobranie informacji od ID lub nazwie towaru
dane_towaru = (input("Podaj id lub nazwę towaru: "))

# Inicjalizacja obu zmiennych wartością None, aby umożliwić try except
towar_id = None
nazwa = None

'''
Przekształcenie danych towaru na int i zapisanie do zmiennej ID, 
jeśli to nie możliwe zostawienie jako string i zapisanie do zmiennej nazwa
'''
try:
    id = int(dane_towaru)
except:
    nazwa = dane_towaru

# Pobranie od użytkownika wartości ilości zakupu
ilosc_zakupu = (input("Podaj ilość: "))

# Próba przekształcenie ilosc_zakupu na int, jeśli to niemożliwe rzuć wyjątek TypeError
try:
    ilosc_zakupu = int(ilosc_zakupu)
except:
    raise TypeError("Ilość powinna być liczbą")

# Użycie DB sprzedaz
cur.execute("USE sprzedaz;")

'''
Jeżeli użytkownik podał ID pobierz z tablicy magazyn stan, towar_id i nazwę
produktu o danym przez użytkownika ID, jeżeli podał nazwę to produktu o danej nazwie
'''
if id != None:
    cur.execute(f"SELECT stan, towar_id, nazwa FROM magazyn WHERE towar_id = {id};")
elif nazwa != None:
    cur.execute(f"SELECT stan, towar_id, nazwa FROM magazyn WHERE nazwa = '{nazwa}';")

# Pobranie wyników zapytania SELECT
row = cur.fetchone()

# Przypisanie odpowiednich wartości z zapytania do zmiennych
ilosc_dostepna = row[0]
towar_id = row[1]
nazwa = row[2]

# Sprawdzenie czy na magazynie jest dostępna ilość towaru
if ilosc_dostepna >= ilosc_zakupu:
    # Pobranie odbiorcy od użytkownika
    odbiorca = input("Podaj odbiorcę: ")
    # Dodanie nowego wpisu do tablicy zamówienie
    cur.execute(f"""INSERT INTO zamowienia 
                (odbiorca, towar, ilosc)
                VALUES 
                ('{odbiorca}', {towar_id}, {ilosc_zakupu})""")
    # Commit polecenia
    cnx.commit()
else:
    # Jeśli na magazynie nie ma tyle towaru
    print(f"Na stanie dostępne jest jedynie {ilosc_dostepna} {nazwa}")

# Zamknięcie połączenia
cnx.close()
