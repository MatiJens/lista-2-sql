USE sprzedaz;

# Wybieramy pełne informacje z tabeli zamówienia oraz nazwę z tabeli magazyn
SELECT zamowienia_id, odbiorca, towar, magazyn.nazwa, ilosc 
FROM zamowienia
# Pobieramy tylko te wartości z magazynu, dla których zamowienie.towar jest równy magazyn.towar_id 
INNER JOIN magazyn ON zamowienia.towar = magazyn.towar_id; 

# Wybieramy towar_id z tablicy magazyn oraz odbiorca z tablicy zamówienia
SELECT magazyn.towar_id, zamowienia.odbiorca
FROM magazyn
# Wybieramy tylko te wartości z zamówienia, dla których magazyn.towar_id jest równy zamowienia.towar
LEFT JOIN zamowienia ON magazyn.towar_id = zamowienia.towar;

# Wybieramy stan i cena jednostkowa z magazynu, mnozymy i sumujemy oraz zapisujemy jako wartosc magazynu
SELECT
	SUM(stan * cena_jednostkowa) AS wartosc_magazynu
FROM
	magazyn;

# Wybieramy wszystko z tablicy magazyn oraz dodajemy nowa kolumne wartosc_towaru
# Nastepnie sortujemy po kolumnie wartosc_towaru
SELECT
    towar_id,
    nazwa,
    stan,
    cena_jednostkowa,
	stan * cena_jednostkowa AS wartosc_towaru
FROM
	magazyn
ORDER BY
	wartosc_towaru DESC;

# Wybieramy kolumne ilosc i liczymy jej srednia wynik zapisujemy jako sr_rozmiar_zam
SELECT
	AVG(ilosc) AS sr_rozmiar_zam
FROM
	zamowienia;
