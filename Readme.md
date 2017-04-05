Sada testů na XQR
=================

Tento skript obsahuje sadu testů, které jsou součástí zadání projektu, doplněnou
o automatické vyhodnocení výsledků a několik dalších testů.

Spuštění všech testů
--------------------

Nejdříve v této složce vytvořte symlink `xqr.py`, který bude ukazovat na vaše
řešení projektu. Poté spusťte:

    ./stud_tests.sh

Tímto se spustí všechny testy.


Spuštění pouze jednoho testu
----------------------------

Pokud chcete spustit jenom jeden test, napište jeho číslo jako parametr skriptu.
Například pokud chcete spustit test č. *69*:

    ./stud_tests.sh 69

V tomto režimu budou i vypsány chybové hlášky vašeho skriptu a obsah výstupního
souboru, který váš skript vytvořil.

**Upozornění:** toto funguje pouze s testy číslo 50 a více. Samostatné spuštění
testů 1 až 49 není podporováno.

Úprava nebo přidání vlastních testů
-----------------------------------

Testovací skript podporuje dva druhy testů:

* **Klasické (1-49)** - tesují vše, co nedokážou poloautomatické testy; například
    zpracování argumentů, chyby při zápisu souborů apod. Každý test je definován
    vstupními daty, spouštěcím příkazem, očekávanými výstpuními daty a očekávaným
    exit kódem.
* **Poloautomatické (50 a více)** - testují správnost SQL dotazů. Všechny testy
    se provádějí nad stejným vstupním souborem `vstup.xml` a skript se vždy spouští
    se stejnými paramatry *(kromě vstupního dotazu)*. Kontroluje se návratový kód
    a vygenerovaný soubor.

Pro změnu klasických testů upravte přímo skript `stud_tests.sh` a/nebo obsah souborů
v adresáři `ref-out`.

Pro změnu poloautomatických testů upravte soubor s dotazy `make-tests.sql`. Soubor
obsahuje seznam testovacích SQL dotazů (jeden na řádek) v následujícím formátu:

    SQL dotaz -- návratový_kód

Tedy na každém řádku je SQL dotaz, za ním mezera, dvě pomlčky, znovu mezera a číslo
očekávaného návratového kódu. Pokud se očekává kód `0`, není nutné ho uvádět
(stačí napsat pouze SQL dotaz). Prázdné řádky a řádky začínající dvěmi pomlčkami
(`--`) se ignorují.

Po dokončení úprav souboru spusťte:

    ./make-tests.py

Tím dojde k vygenerování referenčních souborů všech poloautomatických testů.

**Upozornění:** spuštěním příkazu `./make-tests.py` dojde k přepsání všech
referenčních výsledků výstupy vašeho skriptu *(kromě návratových kódů, které se
berou ze souboru `make-tests.sql`).*

