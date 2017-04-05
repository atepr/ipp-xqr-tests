#!/usr/bin/env bash

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# IPP - xqr - doplňkové testy - 2016/2017
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Činnost: 
# - vytvoří výstupy studentovy úlohy v daném interpretu na základě sady testů
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Popis (README):
#
# Struktura skriptu _stud_tests.sh (v kódování UTF-8):
# Každý test zahrnuje až 4 soubory (vstupní soubor, případný druhý vstupní 
# soubor, výstupní soubor, soubor logující chybové výstupy *.err vypisované na 
# standardní chybový výstup (pro ilustraci) a soubor logující návratový kód 
# skriptu *.!!!). Pro spuštění testů je nutné do stejného adresáře zkopírovat i 
# váš skript. V komentářích u jednotlivých testů jsou uvedeny dodatečné 
# informace jako očekávaný návratový kód. 
#
# Proměnné ve skriptu _stud_tests.sh pro konfiguraci testů:
#  INTERPRETER - využívaný interpret 
#  EXTENSION - přípona souboru s vaším skriptem (jméno skriptu je dáno úlohou) 
#  LOCAL_IN_PATH/LOCAL_OUT_PATH - testování různých cest ke vstupním/výstupním
#    souborům
#  
# Další soubory archivu s doplňujícími testy:
# V adresáři ref-out najdete referenční soubory pro výstup (*.out nebo *.xml), 
# referenční soubory s návratovým kódem (*.!!!) a pro ukázku i soubory s 
# logovaným výstupem ze standardního chybového výstupu (*.err). Pokud některé 
# testy nevypisují nic na standardní výstup nebo na standardní chybový výstup, 
# tak může odpovídající soubor v adresáři chybět nebo mít nulovou velikost.
# V adresáři s tímto souborem se vyskytuje i soubor xqr_options 
# pro nástroj JExamXML, který doporučujeme používat na porovnávání XML souborů. 
# Další tipy a informace o porovnávání souborů XML najdete na Wiki IPP (stránka 
# https://wis.fit.vutbr.cz/FIT/st/cwk.php?title=IPP:ProjectNotes&id=9999#XML_a_jeho_porovnávání).
#
# Doporučení a poznámky k testování:
# Tento skript neobsahuje mechanismy pro automatické porovnávání výsledků vašeho 
# skriptu a výsledků referenčních (viz adresář ref-out). Pokud byste rádi 
# využili tohoto skriptu jako základ pro váš testovací rámec, tak doporučujeme 
# tento mechanismus doplnit.
# Dále doporučujeme testovat různé varianty relativních a absolutních cest 
# vstupních a výstupních souborů, k čemuž poslouží proměnné začínající 
# LOCAL_IN_PATH a LOCAL_OUT_PATH (neomezujte se pouze na zde uvedené triviální 
# varianty). 
# Výstupní soubory mohou při spouštění vašeho skriptu již existovat a pokud není 
# u zadání specifikováno jinak, tak se bez milosti přepíší!           
# Výstupní soubory nemusí existovat a pak je třeba je vytvořit!
# Pokud běh skriptu skončí s návratovou hodnotou různou od nuly, tak není 
# vytvoření souboru zadaného parametrem --output nutné, protože jeho obsah 
# stejně nelze považovat za validní.
# V testech se jako pokaždé určitě najdou nějaké chyby nebo nepřesnosti, takže 
# pokud nějakou chybu najdete, tak na ni prosím upozorněte ve fóru příslušné 
# úlohy (konstruktivní kritika bude pozitivně ohodnocena). Vyhrazujeme si také 
# právo testy měnit, opravovat a případně rozšiřovat, na což samozřejmě 
# upozorníme na fóru dané úlohy.
#
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

TASK=xqr
#INTERPRETER=php5.6
#EXTENSION=php
INTERPRETER=python3
EXTENSION=py

# cesty ke vstupním a výstupním souborům
LOCAL_IN_PATH="input/"
LOCAL_OUT_PATH="output/"
# cesta pro ukládání chybového výstupu studentského skriptu
LOG_PATH="output/"


if [ -z "$1" ]
then

    # test01: Zobrazi napovedu; Expected output: test01.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --help > "${LOCAL_OUT_PATH}test01.out" 2> ${LOG_PATH}test01.err
    echo -n $? > output/test01.!!!

    # test02: Jednoduchy SELECT element FROM ROOT; Expected output: test02.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH}test02.in" --output="${LOCAL_OUT_PATH}test02.out" --qf=input/test02.qu --root=Books 2> ${LOG_PATH}test02.err
    echo -n $? > output/test02.!!!

    # test03: Vyber pomoci SELECT je omezen na dve polozky - soucasne byla odstranena hlavicka; Expected output: test03.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test03.in --output="${LOCAL_OUT_PATH}test03.out" --qf=input/test03.qu --root=OnlyTwoBooks -n 2> ${LOG_PATH}test03.err
    echo -n $? > output/test03.!!!

    # test04: Vypsani pouze prazdneho Rootu pomoci omezeni limitu na 0; Expected output: test04.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH}test04.in" --output="${LOCAL_OUT_PATH}test04.out" --qf=input/test04.qu --root=EmptyRoot -n 2> ${LOG_PATH}test04.err
    echo -n $? > output/test04.!!!

    # test05: SELECT element z nasobneho nodu; Expected output: test05.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH}test05.in" --output=${LOCAL_OUT_PATH}test05.out --qf=input/test05.qu --root=Library 2> ${LOG_PATH}test05.err
    echo -n $? > output/test05.!!!

    # test06: Vyber elementu z podelementu prvniho vyskytu prohledavaneho elementu 'library' s attributem 'my'; Expected output: test06.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH}test06.in" --output="${LOCAL_OUT_PATH}test06.out" --qf=input/test06.qu --root=Titles 2> ${LOG_PATH}test06.err
    echo -n $? > output/test06.!!!

    # test07: Vyber z prvniho elementu obsahujiciho attribut 'my'; Expected output: test07.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH}test07.in" --output=${LOCAL_OUT_PATH}test07.out --qf=input/test07.qu 2> ${LOG_PATH}test07.err
    echo -n $? > output/test07.!!!

    # test08: SELECT s jednoduchou podminkou; Expected output: test08.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test08.in --output="${LOCAL_OUT_PATH}test08.out" --qf=input/test08.qu 2> ${LOG_PATH}test08.err
    echo -n $? > output/test08.!!!

    # test09: dalsi SELECT s jednoduchou podminkou; Expected output: test09.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH}test09.in" --output=${LOCAL_OUT_PATH}test09.out --qf=input/test09.qu 2> ${LOG_PATH}test09.err
    echo -n $? > output/test09.!!!

    # test10: SELECT s chybnou podminkou; Expected output: test10.out; Expected return code: 80
    $INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test10.in --output=${LOCAL_OUT_PATH}test10.out --qf=input/test10.qu 2> ${LOG_PATH}test10.err
    echo -n $? > output/test10.!!!

    # test11: osetreni parametru; Expected output: test11.out; Expected return code: 1
    $INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test11.in --output=${LOCAL_OUT_PATH}test11.out --qf=input/test11.qu --query='SELECT book FROM catalog' 2> ${LOG_PATH}test11.err
    echo -n $? > output/test11.!!!

    # test12: SELECT elementu primo zanoreneho v koreni; Expected output: test12.out; Expected return code: 0
    $INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test12.in --output=${LOCAL_OUT_PATH}test12.out --qf=input/test12.qu --root=MyCatalog 2> ${LOG_PATH}test12.err
    echo -n $? > output/test12.!!!

    # Další testy
    lst=$(cat make-tests-last)
    
    for i in $(seq 50 $lst)
    do
        $INTERPRETER $TASK.$EXTENSION --input=vstup.xml --output=${LOCAL_OUT_PATH}test$i.out --qf=input/test$i.qu --root=knihovna 2> ${LOG_PATH}test$i.err
        echo -n $? > output/test$i.!!!
    done

    range=$(seq -w 1 12; seq 50 $lst)
else
    rm -f ${LOCAL_OUT_PATH}test$1.out
    $INTERPRETER $TASK.$EXTENSION --input=vstup.xml --output=${LOCAL_OUT_PATH}test$1.out --qf=input/test$1.qu --root=knihovna
    echo -n $? > output/test$1.!!!
    if [ -f "${LOCAL_OUT_PATH}test$1.out" ]
    then
        echo "== Obsah souboru ${LOCAL_OUT_PATH}test$1.out =="
        cat ${LOCAL_OUT_PATH}test$1.out
        echo -e "\n== Konec =="
    fi
    range="$1"
fi

YELLOW='\033[1;33m'
GRAY='\033[1;30m'
ORANGE='\033[0;33m'

ENDC='\033[0m'


total=0
good=0

for i in $range
do
    total=$((total+1))
    expected_code=$(cat "ref-out/test$i.!!!")
    actual_code=$(cat "output/test$i.!!!")
    echo -en $YELLOW"Test $i "$ENDC
    if [ "$expected_code" -ne "$actual_code" ]
    then
        echo "- špatný návratový kód (chci $expected_code, vráceno $actual_code)"
        echo -en "\t- "
        cat "input/test$i.qu"
        continue
    fi
    if [ "$i" == "01" ]
    then
        # Bez kontroly vrácený věci
        echo -e $GRAY"ok"
        good=$((good+1))
        continue
    fi
    if [ "$expected_code" -gt 0 ]
    then
        echo -ne $GRAY"ok (kód $expected_code): "
        cat "input/test$i.qu"
        echo -ne $ENDC
        good=$((good+1))
        continue
    fi
    echo "<xml>" > output/test${i}.out.mod
    cat "output/test${i}.out" | sed "s:<?xml.*?>::" >> output/test${i}.out.mod
    echo "</xml>" >> output/test${i}.out.mod
    
    echo "<xml>" > ref-out/test${i}.out.mod
    cat "ref-out/test${i}.out" | sed "s:<?xml.*?>::" >> ref-out/test${i}.out.mod
    echo "</xml>" >> ref-out/test${i}.out.mod
    java -jar jexamxml/jexamxml.jar output/test${i}.out.mod ref-out/test${i}.out.mod output/delta.xml xqr_options >/dev/null
    if [ $? == 0 ]
    then
        echo -en $GRAY"ok"
        good=$((good+1))
    else
        echo -n "FAIL"
    fi
    
    echo -n ": "
    cat "input/test$i.qu"
    echo -ne $ENDC
done

perc=$((100*good/total))
echo -e $ORANGE"Úspěšnost:$ENDC $good/$total ($perc%)"

