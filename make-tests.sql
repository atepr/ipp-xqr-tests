-- Soubor se vstupními dotazy
--
-- Dotazy uvednené v tomto souboru budou provedeny nad souborem 'vstup.xml'.
--
-- -----------------------------------------------------------------------------

-- Klasický dotaz na element s/bez podatributů
SELECT book FROM ROOT
SELECT title FROM ROOT
SELECT book FROM vnoreny
SELECT title FROM vnoreny

-- Dotazy na něco, co není neexistuje nebo něco, co není element
SELECT ROOT FROM ROOT -- 80
SELECT neexistujici FROM ROOT
SELECT NEEXISTUJICI FROM ROOT
SELECT .id FROM ROOT -- 80
SELECT WHERE FROM ROOT -- 80
SELECT FROM ROOT -- 80
SELECT -- 80
SELECT FROM -- 80

-- Všechno za SELECT
SELECT catalog FROM ROOT
SELECT book FROM ROOT
SELECT author FROM ROOT
SELECT vnoreny FROM ROOT

SELECT catalog FROM catalog
SELECT book FROM catalog
SELECT author FROM catalog
SELECT vnoreny FROM catalog

SELECT catalog FROM book
SELECT book FROM book
SELECT author FROM book
SELECT vnoreny FROM book

SELECT catalog FROM author
SELECT book FROM author
SELECT author FROM author
SELECT vnoreny FROM author

SELECT catalog FROM vnoreny
SELECT book FROM vnoreny
SELECT author FROM vnoreny
SELECT vnoreny FROM vnoreny

-- Různé varianty za FROM
SELECT title FROM ROOT
SELECT title FROM catalog
SELECT title FROM book
SELECT title FROM title
SELECT title FROM neexistujici
SELECT title FROM
SELECT title FROM WHERE -- 80
SELECT title FROM WHERE price > 0
SELECT title FROM WHERE neexistujici > 0
SELECT title FROM vnoreny
SELECT title FROM .data-x
SELECT title FROM .data-y
SELECT title FROM vnoreny.data-x
SELECT title FROM .data-z
SELECT title FROM vnoreny.data-z
SELECT title FROM . -- 80
SELECT title FROM vnoreny. -- 80

-- Jednoduchá porovnávání
SELECT book FROM ROOT WHERE -- 80
SELECT book FROM ROOT WHERE title CONTAINS "er"
SELECT book FROM ROOT WHERE neexistujici CONTAINS "er"
SELECT book FROM ROOT WHERE genre CONTAINS "Fantasy"
SELECT book FROM ROOT WHERE price CONTAINS 10 -- 80
SELECT book FROM ROOT WHERE genre = "Fantasy"
SELECT book FROM ROOT WHERE price = 10
SELECT book FROM ROOT WHERE price < 10
SELECT book FROM ROOT WHERE price > 10
SELECT book FROM ROOT WHERE price < -1
SELECT book FROM ROOT WHERE price > +1
SELECT book FROM ROOT WHERE title CONTAINS "Lover Birds"
SELECT book FROM ROOT WHERE title = "Lover Birds"
SELECT book FROM ROOT WHERE title < "Lover Birds"
SELECT book FROM ROOT WHERE title > "Lover Birds"
SELECT book FROM ROOT WHERE author CONTAINS ""

-- Negace
SELECT book FROM ROOT WHERE NOT title CONTAINS "er"
SELECT book FROM ROOT WHERE NOT price < 10
SELECT book FROM ROOT WHERE NOT NOT price < 10
SELECT book FROM ROOT WHERE NOT NOT NOT price < 10
SELECT book FROM ROOT WHERE NOT NOT NOT NOT price < 10
SELECT book FROM ROOT WHERE NOT NOT NOT NOT NOT price < 10
SELECT book FROM ROOT WHERE price < 10 AND price > 40
SELECT book FROM ROOT WHERE NOT price < 10 AND price > 40
SELECT book FROM ROOT WHERE price < 10 AND NOT price > 40
SELECT book FROM ROOT WHERE NOT price < 10 AND NOT price > 40
SELECT book FROM ROOT WHERE NOT NOT price < 10 AND price > 40
SELECT book FROM ROOT WHERE price < 10 AND NOT NOT price > 40
SELECT book FROM ROOT WHERE NOT NOT price < 10 AND NOT price > 40
SELECT book FROM ROOT WHERE NOT price < 10 AND NOT NOT price > 40
SELECT book FROM ROOT WHERE NOT NOT price < 10 AND NOT NOT price > 40

-- Chyby v porovnávajících podmínkách
SELECT book FROM ROOT WHERE title -- 80
SELECT book FROM ROOT WHERE title CONTAINS -- 80
SELECT book FROM ROOT WHERE 10 < price < 20 -- 80
SELECT book FROM ROOT WHERE title CONTAINS ROOT -- 80
SELECT book FROM ROOT WHERE ROOT CONTAINS "er" -- 80
SELECT book FROM ROOT WHERE title CONTAINS 42 -- 80
SELECT book FROM ROOT WHERE price NOT < 10 -- 80
SELECT book FROM ROOT WHERE price < NOT 10 -- 80
SELECT book FROM ROOT WHERE price < 10 NOT -- 80
SELECT book FROM ROOT WHERE OR price < 10 -- 80
SELECT book FROM ROOT WHERE price OR < 10 -- 80
SELECT book FROM ROOT WHERE price < OR 10 -- 80
SELECT book FROM ROOT WHERE price < 10 OR -- 80
SELECT book FROM ROOT WHERE price 10 < -- 80
SELECT book FROM ROOT WHERE 5 < 10 -- 80
SELECT book FROM ROOT WHERE title LIMIT 1 -- 80
SELECT book FROM ROOT WHERE title FROM "Lover Birds" -- 80

-- Chyby při přetypování na typ literálu v podmínce
SELECT book FROM ROOT WHERE title > 5 -- 4
SELECT book FROM ROOT WHERE publish_date > 2000 -- 4
SELECT book FROM ROOT WHERE .poradi = 3 -- 4
SELECT jeste_neco FROM ROOT WHERE book CONTAINS "Maeve Ascendant" -- 4

-- Složitější porovnání (s rozšířením LOG)
SELECT book FROM ROOT WHERE price > 10 AND price < 42
SELECT book FROM ROOT WHERE price < 10 OR price > 42
SELECT book FROM ROOT WHERE price > 5 AND price < 6 OR .taky = 1
SELECT book FROM ROOT WHERE (((price > 10)) AND (((price < 42))))
SELECT book FROM ROOT WHERE price > 10 AND price < 42
SELECT book FROM ROOT WHERE NOT(.taky > 0)
SELECT book FROM ROOT WHERE .taky < 0
SELECT book FROM ROOT WHERE NOT(NOT(.taky > 0))
SELECT book FROM ROOT WHERE NOT(NOT(NOT(.taky > 0)))
SELECT book FROM ROOT WHERE NOT(NOT NOT(.taky > 0))
SELECT book FROM ROOT WHERE NOT NOT NOT(.taky > 0)
SELECT book FROM ROOT WHERE NOT NOT (NOT .taky > 0)
SELECT book FROM ROOT WHERE autor CONTAINS "Peter" OR genre = "Romance" AND price = "4.96" OR genre = "Fantasy" AND NOT author CONTAINS "Eva" OR price.flag = "Y"
SELECT book FROM ROOT WHERE (autor CONTAINS "Tim" OR autor CONTAINS "Eva") AND publish_date CONTAINS "-01"
SELECT book FROM ROOT WHERE publish_date CONTAINS "-01" AND (autor CONTAINS "Tim" OR autor CONTAINS "Eva")

-- Chyby při složitějším porovnání
SELECT book FROM ROOT WHERE (price > 5 AND price < 6 -- 80
SELECT book FROM ROOT WHERE price > 5 AND price < 6) -- 80
SELECT book FROM ROOT WHERE price AND autor -- 80
SELECT book FROM ROOT WHERE price AND (autor CONTAINS "Eva") -- 80
SELECT book FROM ROOT WHERE (autor CONTAINS "Eva") NOT -- 80
SELECT book FROM ROOT WHERE (autor CONTAINS "Eva") (price < 5) AND -- 80
SELECT book FROM ROOT WHERE (autor CONTAINS "Eva") AND price -- 80
SELECT book FROM ROOT WHERE price > 10 AND .taky = (price < 5) -- 80
SELECT book FROM ROOT WHERE publish_date CONTAINS "-01" AND OR (autor CONTAINS "Tim" OR autor CONTAINS "Eva") -- 80
SELECT book FROM ROOT WHERE publish_date CONTAINS "-01" (autor CONTAINS "Tim" OR autor CONTAINS "Eva") -- 80

-- Omezení počtu výsledků
SELECT title FROM ROOT LIMIT -- 80
SELECT title FROM ROOT LIMIT -3 -- 80
SELECT title FROM ROOT LIMIT 0
SELECT title FROM ROOT LIMIT 1
SELECT title FROM ROOT LIMIT 5
SELECT title FROM ROOT LIMIT 100
SELECT book FROM ROOT LIMIT 0
SELECT book FROM ROOT LIMIT 1
SELECT book FROM ROOT LIMIT 3
SELECT book FROM ROOT WHERE .taky > 0 LIMIT 2

-- Řazení (s rozšířením ORD)
SELECT title FROM ROOT ORDER -- 80
SELECT title FROM ROOT ORDER BY -- 80
SELECT title FROM ROOT ORDER BY title -- 80
SELECT title FROM ROOT ORDER BY title LIMIT 5 -- 80
SELECT title FROM ROOT ORDER BY title ASC
SELECT title FROM ROOT ORDER BY title DESC
SELECT title FROM ROOT ORDER BY title ASC LIMIT 5
SELECT title FROM ROOT ORDER BY title DESC LIMIT 5
SELECT book FROM ROOT ORDER BY price ASC LIMIT 10
SELECT book FROM vnoreny ORDER BY .poradi ASC LIMIT 10
SELECT book FROM ROOT ORDER BY price DESC LIMIT 10
SELECT book FROM vnoreny ORDER BY .poradi DESC LIMIT 10
SELECT book FROM vnoreny ORDER BY author.poradi ASC LIMIT 10 -- 4
SELECT book FROM vnoreny ORDER BY .taky ASC LIMIT 10 -- 4


-- Různé povolené i nepovolené znaky v názech elemetnů
-- (viz http://stackoverflow.com/q/1478486)
SELECT obyc FROM divny
SELECT A-Z0123 FROM divny
SELECT A-Z0123/ FROM divny -- 80
SELECT -abc FROM divny -- 80
SELECT abc- FROM divny
SELECT ❤ FROM divny -- 80
SELECT Ø FROM divny
SELECT ØØ FROM divny
SELECT Ǯ FROM divny
SELECT _· FROM divny
SELECT můj FROM divny

