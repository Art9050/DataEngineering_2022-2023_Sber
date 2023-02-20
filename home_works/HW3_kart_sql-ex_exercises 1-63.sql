/* 
Прорешать задания на sql-ex.ru
Задания обучающего этапа с выбором СУБД - PGSQL

Основная цель - задания на JOIN (6, 7, 9, 13, 14, 18, 19, 21, 23, 25, 26, 27, 28, 32, 36, 37, 39, 43, 48, 49, 50, 51, 52, 54, 57, 58)
Вторичная цель - 40 первых заданий

Для тех кому мало - 60 первых заданий

Формат сдачи - скриншот с платформы с зачтёнными заданиями и решения/исходники

Проверка - корректность написания запросов, корректность выполнения заданий 
*/

sql-ex.ru
/* Задание: 1 (Serge I: 2002-09-30)
--Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd
	
Select model, speed, hd 
From PC 
Where price < 500;
*/
/* Задание: 2 (Serge I: 2002-09-21)
--Найдите производителей принтеров. Вывести: maker

Select Distinct maker 
From Product
WHERE type = 'Printer'
*/
/* Задание: 3 (Serge I: 2002-09-30)
--Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

Select model, ram, screen
From Laptop
Where price > 1000
*/
/* Exercise: 4 (Serge I: 2002-09-21)
--Find all records from the Printer table containing data about color printers.

Select *
From Printer
Where color = 'y'
*/
/* Exercise: 5 (Serge I: 2002-09-30)
--Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.

Select model, speed, hd
From PC
Where cd in ('12x', '24x') and price < 600
*/
/* Exercise: 6 (Serge I: 2002-10-28)
--For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed.

Select maker, speed
From Laptops
Where hd >= 10
*/
/* Задание: 6 (Serge I: 2002-10-28)
--Для каждого производителя, выпускающего ПК-блокноты c объёмом 
--жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. 
--Вывод: производитель, скорость.

Select DISTINCT Product.maker AS Maker, Laptop.speed
From Product JOIN 
 Laptop ON Laptop.model = Product.model
WHERE Laptop.hd >= 10 AND Product.type = 'laptop'	
ORDER BY Laptop.speed	
*/
/* Задание: 7 (Serge I: 2002-11-02)
--Найдите номера моделей и цены всех имеющихся в продаже 
--продуктов (любого типа) производителя B (латинская буква).
	
SELECT DISTINCT PC.model AS model, PC.price AS price
FROM PC JOIN Product ON 
 Product.model = PC.model 
WHERE Product.maker = 'B'
UNION
SELECT DISTINCT Laptop.model AS model, Laptop.price AS price
FROM Laptop JOIN Product ON
 Product.model = Laptop.model
WHERE Product.maker = 'B'
UNION
SELECT DISTINCT Printer.model AS model, Printer.price AS price
FROM Printer JOIN Product ON
 Product.model = Printer.model
WHERE Product.maker = 'B'
*/
/* Задание: 8 (Serge I: 2003-02-03)
Найдите производителя, выпускающего ПК, но не ПК-блокноты.

SELECT DISTINCT maker
FROM Product 
Where type = 'PC'
EXCEPT --Перечень из Product что делают только PC
SELECT DISTINCT maker
FROM Product 
Where type = 'Laptop'
EXCEPT --Перечень производителей Laptop
Select DISTINCT maker
From Product AS P JOIN Laptop AS L
 ON L.model = P.model
*/
/* Задание: 9 (Serge I: 2002-11-02)
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

Select DISTINCT maker
From Product 
 Join PC ON
 Product.model = PC.model
Where speed >= 450
*/
/* Задание: 10 (Serge I: 2002-09-23)
Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
SELECT model, price
FROM Printer
WHERE price = (SELECT MAX(price)
				FROM Printer)
 */
/* Задание: 11 (Serge I: 2002-11-02)
Найдите среднюю скорость ПК.
SELECT AVG(speed)
FROM PC */
/* Задание: 12 (Serge I: 2002-11-02)
Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT AVG(speed)
FROM Laptop
WHERE price > 1000 */
/* Задание: 13 (Serge I: 2002-11-02)
Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT AVG(speed)
FROM PC JOIN Product
		ON PC.model = Product.model
WHERE maker = 'A' */
/* Задание: 14 (Serge I: 2002-11-05)
Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT S.class, name, country
FROM Ships AS S JOIN Classes AS C
				ON S.class = C.class
WHERE numGuns >= 10 */
/* Задание: 15 (Serge I: 2003-02-03)
Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT HD
FROM PC GROUP BY HD
HAVING COUNT(HD)  > 1 */
/* Задание: 16 (Serge I: 2003-02-03)
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. 
В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), 
Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT A.model AS model_1, B.model AS model_2, A.speed, A.RAM
FROM PC AS A, PC AS B
WHERE A.speed = B.speed AND A.RAM = B.RAM
		AND A.model > B.model
ORDER BY A.model, A.speed, A.RAM */
/* Задание: 17 (Serge I: 2003-02-03)
Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
Вывести: type, model, speed

SELECT DISTINCT P.type, L.model, L.speed
FROM Product AS P, Laptop AS L
WHERE P.model = L.model 
	AND L.speed < ALL(SELECT speed
				FROM PC) */
/* Задание: 18 (Serge I: 2003-02-03)
Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price				

SELECT  DISTINCT P.maker, Printer.price
FROM Product AS P JOIN Printer 
			ON P.model = Printer.model
WHERE Printer.color = 'y' 
	AND price = (SELECT MIN(price) 
				FROM Printer
				WHERE color = 'y') ---Работает


SELECT DISTINCT c.maker, a.priceA AS price ---из ц.принтерам с мин ценой приписаными производителем и моделью выбираем нужное
FROM 
	(SELECT MIN(price) AS priceA 
     FROM Printer 
     WHERE color ='y'
    ) AS a  --- Выбирает мин.цену для цветных принтеров
	INNER JOIN Printer AS b ON a.priceA = b.price  --- выбирает те ц.принтеры которые указаны с мин ценой
	INNER JOIN Product AS c ON b.model = c.model;  --- к ц.принтерам с мин ценой приписываем производителя и модель
WHERE color ='y' ---Неубирает дубликаты */
/* Задание: 19 (Serge I: 2003-02-13)
Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.

SELECT P.maker, AVG(screen) AS screen
FROM Laptop JOIN Product AS P ON
	Laptop.model = P.model
GROUP BY P.maker
 */
/* Задание: 20 (Serge I: 2003-02-13)
Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.

SELECT Maker, COUNT(*) AS CountModel
FROM Product
WHERE type = 'PC' 
GROUP BY Maker
HAVING COUNT(*) >= 3 */
/* Задание: 21 (Serge I: 2003-02-13)
Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.

SELECT DISTINCT maker, MAX(price) AS MaxPrice
FROM PC JOIN Product AS P 
			ON P.model = PC.model
GROUP BY maker
 */
/* Задание: 22 (Serge I: 2003-02-13)
Для каждого значения скорости ПК, превышающего 600 МГц, определите 
среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.

SELECT DISTINCT speed, AVG(price) AS AvgPrice
FROM PC
WHERE speed > 600
GROUP BY speed */
/* Задание: 23 (Serge I: 2003-02-14)
Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
Вывести: Maker

SELECT maker
FROM Product AS P JOIN PC 
	ON P.model = PC.model
WHERE speed >= 750
INTERSECT
SELECT maker
FROM Product AS P JOIN Laptop AS L 
	ON P.model = L.model
WHERE speed >= 750
 */
/* Задание: 24 (Serge I: 2003-02-03)
Перечислите номера моделей любых типов, имеющих 
самую высокую цену по всей имеющейся в базе данных продукции.

WITH GeneralPriceTable(model, price) AS (
	SELECT model, price From PC
	UNION
	SELECT model, price From Laptop
	UNION
	SELECT model, price From Printer
	)
SELECT DISTINCT P.model 
FROM GeneralPriceTable AS GPT JOIN Product AS P
	ON GPT.model = P.model
WHERE price = (SELECT MAX(price)
					FROM GeneralPriceTable) */
/* Задание: 25 (Serge I: 2003-02-14)
Найдите производителей принтеров, которые 
производят ПК с наименьшим объемом RAM и с самым 
быстрым процессором среди всех ПК, имеющих 
наименьший объем RAM. Вывести: Maker
------------------------------------------------------------------------------------------
SELECt DISTINCT * 
from (
	select maker 
	from product
	WHERE model in 
		(SELECT model 
		from 
			(select * 
			from PC 
			where ram = 
				(select min(ram) 
				from PC)) as a
	where speed = 
		(select max(speed) 
		from PC 
		where ram = 
			(select min(ram) 
			from PC))
		)
	) as s
where maker in 
	(select maker 
	from product 
	where type = 'Printer')
------------------------------------------------------------------------------------------
---- не прошел тест на Б2--
WITH ProdPC AS(SELECT maker, ram, speed
				FROM PC JOIN Product AS P ON 
				PC.model = P.model
				)
SELECT DISTINCT maker
FROM Printer AS Pr JOIN Product AS P ON 
				Pr.model = P.model
WHERE maker IN (SELECT DiSTINCT maker --- производители мин скор + макс скор
				FROM ProdPC
				WHERE speed >= (SELECT MAX(speed) ---Отбор мин скор + макс скор
								FROM 
									(SELECT maker, speed
									FROM ProdPC
									WHERE ram <= (SELECT MIN(ram) FROM ProdPC)
									) AS K ---Отбор по мин скорости
								)
				) ---- не прошел тест на Б2.

---- не прошел тест на Б2--
WITH ProdPC AS(SELECT maker, ram, speed
				FROM PC JOIN Product AS P ON 
				PC.model = P.model
				)
SELECT DISTINCT maker
FROM Product
WHERE type = 'Printer' 
	AND maker IN (SELECT DiSTINCT maker --- производители мин скор + макс скор
					FROM ProdPC
					WHERE speed >= (SELECT MAX(speed) ---Отбор мин скор + макс скор
									FROM 
										(SELECT maker, speed
										FROM ProdPC
										WHERE ram <= (SELECT MIN(ram) FROM ProdPC)
										) AS K ---Отбор по мин скорости
									)
					) ---- не прошел тест на Б2.
-------------------------------------------------------------------------- */
/* Задание: 26 (Serge I: 2003-02-14)
Найдите среднюю цену ПК и ПК-блокнотов, 
выпущенных производителем A (латинская буква). 
Вывести: одна общая средняя цена.
WITH ALLPrice AS 
				(SELECT maker, 
						price
				FROM PC JOIN Product P
						ON P.model = PC.model
				WHERE maker = 'A'
				UNION ALL
				SELECT maker, 
						price
				FROM Laptop L JOIN Product P
						ON P.model = L.model
				WHERE maker = 'A'
				)
SELECT AVG(price) AS AVG_price
From ALLPrice */
/* Задание: 27 (Serge I: 2003-02-03)
Найдите средний размер диска ПК каждого 
из тех производителей, которые выпускают 
и принтеры. Вывести: maker, средний размер HD.
--- не прошел тест на Б2
SELECT 
	P.maker, 
	AVG(hd)
FROM PC JOIN Product P
			ON P.model = PC.model
GROUP BY P.maker
HAVING P.maker in 
		(SELECT P.maker
		FROM Printer Pr JOIN Product P
					ON P.model = Pr.model
		) 
--- не прошел тест на Б2
WITH AVG_HD AS (
				SELECT 
					P.maker, 
					hd
				FROM PC JOIN Product P
						ON P.model = PC.model
				where P.maker in (SELECT P.maker
									FROM Printer Pr 
										JOIN Product P
										ON P.model = Pr.model
									)
				)
---Решение---			
SELECT maker, AVG(hd) AS AVG_HD 
From  AVG_HD
GROUP BY maker
SELECT 
	P.maker, 
	AVG(hd)
FROM PC JOIN Product P
			ON P.model = PC.model
GROUP BY P.maker
HAVING P.maker in 
		(SELECT maker
		FROM Product 
		WHERE type = 'Printer'
		) */
/* Задание: 28 (Serge I: 2012-05-04)
Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

SELECT 
	COUNT(a.maker)
FROM 
	(SELECT maker, 
		COUNT(model) as COUNT_model
	FROM Product
	GROUP BY maker
	HAVING COUNT(model) = 1
	) AS a */
/* Задание: 29 (Serge I: 2003-02-14)
В предположении, что приход и расход денег на 
каждом пункте приема фиксируется не чаще одного 
раза в день [т.е. первичный ключ (пункт, дата)], 
написать запрос с выходными 
данными (пункт, дата, приход, расход). 
Использовать таблицы Income_o и Outcome_o.

WITH PointDate AS --- список первичных ключей для обоих таблиц
		(SELECT point, date
		FROM Income_o
		UNION
		SELECT point, date
		FROM Outcome_o)
SELECT 
	PD.point, 
	PD.date,
	inc,
	out
FROM PointDate PD 
	FULL JOIN Income_o In_o
		ON In_o.point = PD.point 
		and In_o.date = PD.date
			FULL JOIN Outcome_o Ou_o
				ON Ou_o.point = PD.point 
				and Ou_o.date = PD.date
*/
/* Задание: 30 (Serge I: 2003-02-14)
В предположении, что приход и расход денег на каждом 
пункте приема фиксируется произвольное число раз 
(первичным ключом в таблицах является столбец code), 
требуется получить таблицу, в которой каждому пункту 
за каждую дату выполнения операций будет соответствовать 
одна строка.
Вывод: point, date, суммарный расход пункта за день (out), 
суммарный приход пункта за день (inc). 
Отсутствующие значения считать неопределенными (NULL).

SELECT DISTINCT--- один день одна запись -- работает -- 8 записей
	point,
	date,	
	(SELECT SUM(inc) 
	FROM Income
	WHERE i.point = point
	and i.date = date) AS Income
FROM Income i 

SELECT DISTINCT--- один день одна запись -- работает -- 14 записей
	point,
	date,	
	(SELECT SUM(out) 
	FROM Outcome
	WHERE o.point = point
	and o.date = date) AS Outcome
FROM Outcome o

SELECT DISTINCT
	i.point,
	i.date,	
	Outcome,
	(SELECT SUM(inc) 
	FROM Income
	WHERE i.point = point
	and i.date = date) AS Income
FROM Income i
left JOIN 
	(SELECT DISTINCT
		point,
		date,	
		(SELECT SUM(out) 
		FROM Outcome
		WHERE o.point = point
			and o.date = date) AS Outcome
	FROM Outcome o) as a
ON i.point = a.point
	and i.date = a.date
UNION 
SELECT DISTINCT
	a.point,
	a.date,	
	Outcome,
	(SELECT SUM(inc) 
	FROM Income
	WHERE i.point = point
	and i.date = date) AS Income
FROM Income i
right JOIN 
	(SELECT DISTINCT
		point,
		date,	
		(SELECT SUM(out) 
		FROM Outcome
		WHERE o.point = point
			and o.date = date) AS Outcome
	FROM Outcome o) as a
ON i.point = a.point
	and i.date = a.date */
/* Задание: 31 (Serge I: 2002-10-22)
Для классов кораблей, калибр орудий которых 
не менее 16 дюймов, укажите класс и страну.

SELECT 
	class,
	country
FROM Classes 
WHERE bore >= 16; */
/* Задание: 32 (Serge I: 2003-02-17)
Одной из характеристик корабля является половина 
куба калибра его главных орудий (mw). С точностью 
до 2 десятичных знаков определите среднее значение 
mw для кораблей каждой страны, у которой есть корабли 
в базе данных.

-----------Вар 1------------------
-----------------------------------------------------------------------------
WITH AllShips As (  --- Несовпадение данных---
	SELECT ---выводит корабли из Ships
		C.class,
		country,
		bore,
		name
	FROM Classes C 
	inner JOIN Ships S --- только те что есть в Ships
	ON S.class = C.class
	UNION ALL
	SELECT ---выводит корабли из Outcomes что нет в Ships
		C.class,
		country,
		bore,
		name
	FROM Classes C 
	LEFT JOIN Ships S
		ON S.class = C.class
	WHERE C.class in (
		SELECT ship
		FROM Outcomes
		WHERE ship not in (SELECT name from SHIPS)
		)
)
SELECT  
	country,
	---CAST((AVG(bore) * AVG(bore) * AVG(bore) / 2) AS NUMERIC(6,2))  AS AVG_bore
	CAST(AVG(POWER(bore,3) / 2) AS NUMERIC(6,2))
FROM AllShips A
GROUP BY A.country    --- Несовпадение данных---
-----------Вар 2------------------
---------------------------------------------------------------------------------------
WITH AllShips As (
SELECT distinct
	COALESCE(name, ship) name,
	COALESCE(class, ship) class,
	launched
from ships s
full join outcomes o 
	on o.ship = s.name
)
SELECT
	country,
	---CAST((AVG(bore) * AVG(bore) * AVG(bore) / 2) AS NUMERIC(6,2))  AS AVG_bore
	CAST(AVG(POWER(bore,3) / 2) AS NUMERIC(6,2)) --- почему одно работает а другое нет
FROM (SELECT
		name,
		c.class,
		launched,
		country,
		bore
	FROM AllShips A
	JOIN Classes C
		ON A.class = C.class
	) as a
GROUP BY country --- работает
---------------------------------------------------------------------------------------  */
/* Задание: 33 (Serge I: 2002-11-02)
Укажите корабли, потопленные в сражениях в 
Северной Атлантике (North Atlantic). Вывод: ship.

SELECT ship
FROM Outcomes 
WHERE battle = 'North Atlantic'
	AND result =  'sunk' */
/* Задание: 34 (Serge I: 2002-11-04)
По Вашингтонскому международному договору от начала 1922 г. 
запрещалось строить линейные корабли водоизмещением 
более 35 тыс.тонн. Укажите корабли, нарушившие этот 
договор (учитывать только корабли c известным годом 
спуска на воду). Вывести названия кораблей.
SELECT DISTINCT 
	name --- Вывести названия кораблей.
FROM Ships S, Classes C
WHERE 
	launched is not NULL ---c известным годом
	AND name is not NULL 
	AND S.Class = C.Class
	AND launched >= 1922 ---от начала 1922 г.
	AND displacement > 35000 ---водоизмещением более 35 тыс.тонн.
	AND displacement is not NULL
	AND type = 'bb' ---линейные корабли
	
---- не прошел тест на Б2--
SELECT DISTINCT 
	name
FROM Classes C, (SELECT DISTINCT
					name, 
					Class
				FROM Ships 
				WHERE launched is not NULL
					AND launched >= 1922) S
WHERE S.Class = C.Class
	AND displacement > 35000
------------------------------------------------------------- */
/* Задание: 35 (qwrqwr: 2012-11-23)
В таблице Product найти модели, которые 
состоят только из цифр или только из 
латинских букв (A-Z, без учета регистра).
Вывод: номер модели, тип модели.

SELECT model, type 
FROM product 
WHERE 
	model NOT LIKE '%[^0-9]%' 
	OR 
	model NOT LIKE '%[^a-z]%' */
/* Задание: 36 (Serge I: 2003-02-17)
Перечислите названия головных кораблей, имеющихся в базе данных (учесть корабли в Outcomes).

SELECT name FROM ships WHERE name = class
UNION
SELECT ship FROM Outcomes WHERE name in (select class FROM Classes) */
/* Задание: 37 (Serge I: 2003-02-17)
Найдите классы, в которые входит только один корабль из базы данных 
(учесть также корабли в Outcomes).
SELECT class
FROM(
	SELECT name, s.class FROM Ships S JOIN Classes C ON s.class = c.class
	UNION
	SELECT ship, c.class FROM Outcomes O JOIN Classes C ON o.ship = c.class
	) AS a
GROUP BY class
HAVING COUNT(name) = 1 */
/* Задание: 38 (Serge I: 2003-02-19)
Найдите страны, имевшие когда-либо классы 
обычных боевых кораблей ('bb') и имевшие 
когда-либо классы крейсеров ('bc').

SELECT country FROM Classes WHERE type = 'bb'
INTERSECT 
SELECT country FROM Classes WHERE type = 'bc' */
/* Задание: 39 (Serge I: 2003-02-14)
Найдите корабли, `сохранившиеся для будущих сражений`; 
т.е. выведенные из строя в одной битве (damaged), 
они участвовали в другой, произошедшей позже.
---join ---exists------------------------------------------
SELECT ship ------ не прошел тест на Б2
FROM Outcomes O
JOIN Battles B ON battle = name 
GROUP BY ship
HAVING COUNT(battle) > 1
AND EXISTS
	(SELECT ship, date
	FROM Outcomes 
	JOIN Battles B ON battle = name 
	WHERE result = 'damaged')
--------------------------------------------------------
select distinct ship from(
---макс дата для поврежденных кораблей
	SELECT ship,MAX(date) as dtd  FROM (SELECT *
							FROM Outcomes 
							JOIN Battles B ON battle = name ) AS a
	WHERE EXISTS	
		(SELECT ship, date, battle
		FROM Outcomes o
		JOIN Battles B ON battle = name 
		WHERE result = 'damaged'
		AND ship = a.ship
		)
	GROUP BY ship 
EXCEPT 
---мин дата для поврежденных кораблей когда были повреждены
	SELECT ship,Min(date) as dtd FROM (SELECT *
							FROM Outcomes 
							JOIN Battles B ON battle = name ) AS a
	WHERE EXISTS	
		(SELECT ship, date, battle
		FROM Outcomes o
		JOIN Battles B ON battle = name 
		WHERE result = 'damaged'
		AND ship = a.ship
		) and result = 'damaged'
	GROUP BY ship
) as a
------------------------------------------------------- */	
/* Задание: 40 (Serge I: 2012-04-20)
Найти производителей, которые выпускают более одной модели, 
при этом все выпускаемые производителем модели являются продуктами одного типа.
Вывести: maker, type

SELECT 
	maker,
	type 
FROM
(
	SELECT 
		maker, 
		MAX(type) AS type, 
		MAX(CountModel) AS CountModel 
	FROM
		(SELECT 
			maker, 
			type, 
			COUNT(model) as CountModel 
		FROM Product
		GROUP BY maker, type) AS A
	GROUP BY maker
	HAVING  COUNT(type) = 1
) AS a
WHERE CountModel > 1 */
/* Задание: 41 (Serge I: 2019-05-31)
Для каждого производителя, у которого присутствуют модели хотя 
бы в одной из таблиц PC, Laptop или Printer,
определить максимальную цену на его продукцию.
Вывод: имя производителя, если среди цен на продукцию данного 
производителя присутствует NULL, то выводить для этого производителя NULL,
иначе максимальную цену.
------------------------------------------------
WITH ALL_Price AS
(SELECT 
	maker, 
	P.model, 
	price  
FROM Product P 
inner JOIN 
	(SELECT model, price FROM PC
	UNION
	SELECT model, price FROM Laptop
	UNION
	SELECT model, price FROM Printer
	) as a 
		ON P.model = a.model
)
SELECT distinct
maker,
CASE
	WHEN 
		EXISTS(SELECT price from ALL_Price A1
		WHERE A1.maker = A2.maker
		AND price IS NULL) 
		THEN NULL
	Else (SELECT MAX(price) from ALL_Price A1
		WHERE A1.maker = A2.maker)
END as price
FROM ALL_Price A2
------------------------------------------------ */
/* Задание: 42 (Serge I: 2002-11-05)
Найдите названия кораблей, потопленных в сражениях, 
и название сражения, в котором они были потоплены
SELECT ship, battle FROM Outcomes 
WHERE result = 'sunk'
 */
/* Задание: 43 (qwrqwr: 2011-10-28)
Укажите сражения, которые произошли в годы, не 
совпадающие ни с одним из годов спуска кораблей на воду.

SELECT name FROM Battles
WHERE NOT EXISTS (SELECT launched from Ships
WHERE DATEPART(YEAR, date) = launched)
 */
/* Задание: 44 (Serge I: 2002-12-04)
Найдите названия всех кораблей в базе данных, начинающихся с буквы R.

SELECT name FROM Ships
Where name like 'R%'
UNION
SELECT Ship FROM Outcomes
Where Ship like 'R%' */
/* Задание: 45 (Serge I: 2002-12-04)
Найдите названия всех кораблей в базе данных, состоящие 
из трех и более слов (например, King George V). ---'% % %'
Считать, что слова в названиях разделяются единичными пробелами, 
и нет концевых пробелов.

SELECT name FROM Ships
Where name like '% % %'
UNION
SELECT Ship FROM Outcomes
Where Ship like '% % %' */
/* Задание: 46 (Serge I: 2003-02-14)
Для каждого корабля, участвовавшего в сражении 
при Гвадалканале (Guadalcanal), вывести название, 
водоизмещение и число орудий.

SELECT Ship, displacement, numGuns class FROM Outcomes 
LEFT JOIN Ships S
	ON Ship = name
	LEFT JOIN Classes C
		ON COALESCE(S.class, Ship) = C.class
Where battle = 'Guadalcanal' */
/* Задание: 47 (Serge I: 2019-06-07)
Определить страны, которые потеряли в сражениях все свои корабли.
---------------------------------------------------------------
SELECT country FROM ( ---не прошел тест на Б2
SELECT COUNT(A.class) as SunkClass, country FROM 
	(SELECT DISTINCT A.Name, result, COALESCE(S.class, A.Name) AS class
	FROM 
		(SELECT Name FROM Ships --- Перечень всех корабликов
		Union 
		SELECT Ship FROM Outcomes
		) as A
	INNER JOIN Outcomes ---Находим уничтоженные кораблики 
		ON Name = ship
	LEFT JOIN Ships S --- для нахождения классов
		ON A.Name = S.Name
	WHERE result = 'sunk'
	) AS a
Join Classes C --- находим страны
	ON A.class = C.class
GROUP BY country
INTERSECT 
SELECT COUNT(A.class) as SunkClass, country FROM 
	(SELECT DISTINCT A.Name, COALESCE(S.class, A.Name) AS class
	FROM 
		(SELECT Name FROM Ships --- Перечень всех корабликов
		Union 
		SELECT Ship FROM Outcomes
		) as A
	LEFT JOIN Ships S --- для нахождения классов
		ON A.Name = S.Name
	) AS a
Join Classes C --- находим страны
	ON A.class = C.class
GROUP BY country
) as f
--------------------------------------------------------------- */
/* Задание: 48 (Serge I: 2003-02-16)
Найдите классы кораблей, в которых хотя бы один корабль был потоплен в сражении.
---------------------------------------------------------------
SELECT DISTINCT A.class as SunkClass FROM ---не прошел тест на проверочной базе
	(SELECT DISTINCT A.Name, result, COALESCE(S.class, A.Name) AS class
	FROM 
		(SELECT Name FROM Ships --- Перечень всех корабликов
		Union 
		SELECT Ship FROM Outcomes
		) as A
	INNER JOIN Outcomes ---Находим уничтоженные кораблики 
		ON Name = ship
	LEFT JOIN Ships S --- для нахождения классов
		ON A.Name = S.Name
	WHERE result = 'sunk'
	) AS a
INNER Join Classes C --- находим страны
	ON A.class = C.class
-------------------------------------------------------------- */-
/* Задание: 49 (Serge I: 2003-02-17)
Найдите названия кораблей с орудиями калибра 16 дюймов (учесть корабли из таблицы Outcomes).
SELECT a.name FROM 
(SELECT Name FROM SHIPS
UNION
SELECT SHIP FROM Outcomes
) a
LEFT JOIN Ships S ON a.name = s.name
LEFT JOIN Classes C ON COALESCE(s.class, a.name) = c.class
WHERE bore = '16'
 */
/* Задание: 50 (Serge I: 2002-11-05)
Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
SELECT DISTINCT battle FROM Outcomes Left JOIN ships ON name = Ship
WHERE Class = 'Kongo' */
/* Задание: 51 (Serge I: 2003-02-17)
Найдите названия кораблей, имеющих наибольшее число орудий 
среди всех имеющихся кораблей такого же водоизмещения 
(учесть корабли из таблицы Outcomes).
-----------------------------------------------------------------
WITH AllShips AS (
	SELECT a.name, COALESCE(s.class, a.name) class, numGuns, displacement
	FROM 
	(SELECT Name FROM SHIPS
	UNION
	SELECT SHIP FROM Outcomes
	) a
	LEFT JOIN Ships S 
		ON a.name = s.name
	LEFT JOIN Classes C 
		ON COALESCE(s.class, a.name) = c.class
)
SELECT name 
FROM AllShips A
WHERE numGuns >= ALL (SELECT numGuns 
					FROM AllShips
					WHERE A.displacement = displacement
					)
	AND numGuns is not NULL
----------------------------------------------------------------- */
/* Задание: 52 (qwrqwr: 2010-04-23)
Определить названия всех кораблей из таблицы Ships, которые могут быть линейным японским кораблем,
имеющим число главных орудий не менее девяти, калибр орудий менее 19 дюймов и водоизмещение не более 65 тыс.тонн
------------------------------------------------------------------------------------------
SELECT name FROM Ships S
FULL JOIN Classes C ON S.class = COALESCE(C.class, S.name)
WHERE 
(numGuns >=9 OR numGuns is NULL)
AND (displacement <= 65000 OR displacement is NULL)
AND (bore < 19 OR bore is NULL)
AND (country = 'Japan'  or country is null)
AND (type = 'bb'  or type is null)
AND  name is not null
------------------------------------------------------------------------------------------- */
/* Задание: 53 (Serge I: 2002-11-05)
Определите среднее число орудий для классов линейных кораблей.
Получить результат с точностью до 2-х десятичных знаков.
-------------------------------------------------------------------------------------------
SELECT 
	CAST(AVG(CAST(COALESCE(numGuns, 0) AS NUMERIC(6,2)))AS NUMERIC(6,2)) AS AVG_numGuns 
FROM Classes
WHERE type = 'bb'
------------------------------------------------------------------------------------------- */
/* Задание: 54 (Serge I: 2003-02-14)
С точностью до 2-х десятичных знаков определите среднее 
число орудий всех линейных кораблей (учесть корабли из 
таблицы Outcomes).
-------------------------------------------------------------------------------------------
SELECT 
CAST(AVG(CAST(COALESCE(numGuns, 0) AS NUMERIC(6,2)))AS NUMERIC(6,2)) AS AVG_numGuns 
FROM
	(SELECT name FROM Ships
	UNION
	SELECT Ship FROM Outcomes) AS a
FULL JOIN Ships S ON a.name = S.name
LEFT JOIN Classes C ON COALESCE(S.class, a.name) = C.class
WHERE type = 'bb'
------------------------------------------------------------------------------------------- */
/* Задание: 55 (Serge I: 2003-02-16)
Для каждого класса определите год, когда был спущен на воду первый 
корабль этого класса. Если год спуска на воду головного корабля 
неизвестен, определите минимальный год спуска на воду кораблей этого класса. 
Вывести: класс, год.
-------------------------------------------------------------------------------------------
SELECT DISTINCT
	COALESCE(S.class, C.class) AS ShipClass,
	COALESCE(launched, (SELECT MIN(launched) FROM Ships WHERE class = COALESCE(S.class, C.class)))
FROM Classes C
LEFT JOIN Ships S ON S.class = C.class
WHERE launched is NULL or
launched = (SELECT MIN(launched) FROM Ships WHERE class = COALESCE(S.class, C.class))
------------------------------------------------------------------------------------------- */
/* Задание: 56 (Serge I: 2003-02-16)
Для каждого класса определите число кораблей 
этого класса, потопленных в сражениях. 
Вывести: класс и число потопленных кораблей.
-------------------------------------------------------------------------------------------
SELECT 
	Class,
	COUNT(Ship)
FROM Classes C
LEFT JOIN (SELECT 
				Ship,
				COALESCE(Class, Ship) AS ShipClass
			FROM Outcomes
			LEft join Ships ON Ship = Name
			WHERE result = 'sunk') as a 
		on ShipClass = C.class
GROUP BY Class
------------------------------------------------------------------------------------------- */
/* Задание: 57 (Serge I: 2003-02-14)
Для классов, имеющих потери в виде потопленных кораблей и 
не менее 3 кораблей в базе данных, вывести имя класса и 
число потопленных кораблей.
----Явные операции соединения-GROUP BY-HAVING-Объединение-IN---
-------------------------------------------------------------------------------------------
SELECT 
	C.Class,
	---COUNT(nm) as nm,
	COUNT(result) as result
FROM Classes C
LEFT JOIN (
	SELECT DISTINCT
		COALESCE(name, Ship) as nm,
		COALESCE(Class, Ship) as Class
	FROM Ships
	FULL JOIN Outcomes ON Ship = Name
) as B on B.Class = c.Class
LEFT JOIN (
	SELECT 
		COALESCE(Class, Ship) AS ShipClass,
		COALESCE(name, Ship) AS Name,
		result
	FROM Outcomes
	LEft join Ships ON Ship = Name
	WHERE result = 'sunk'
) as a on a.Name = nm
GROUP by C.Class
HAVING COUNT(nm) >= 3 and COUNT(result) > 0
------------------------------------------------------------------------------------------- */
/* Задание: 58 (Serge I: 2009-11-13)
Для каждого типа продукции и каждого производителя из 
таблицы Product c точностью до двух десятичных знаков найти 
процентное 
отношение числа моделей данного типа данного производителя 
к общему числу моделей этого производителя.
Вывод: maker, type, процентное отношение числа моделей 
данного типа к общему числу моделей производителя
----Получение итоговых значений--Преобразoвание типов--Явные операции соединения---
----Декартово произведение--Коррелирующие подзапросы--Целочисленное деление--------
-------------------------------------------------------------------------------------------
SELECT DISTINCT 
	maker, 
	a.type,
	(SELECT COUNT(model) FROM Product WHERE maker = P.maker and type = a.type GRoup by maker, type) /
		(SELECT COUNT(model) FROM Product WHERE maker = P.maker GRoup by maker) * 100 as prc
FROM Product P, (SELECT DISTINCT type
FROM Product) as a			
-------------------------------------------------------------------------------------------
SELECT DISTINCT 
	maker, 
	a.type,
	CAST( 
			COALESCE((
			(SELECT CAST(COUNT(model) AS NUMERIC(6,2)) FROM Product WHERE maker = P.maker and type = a.type GRoup by maker, type) 
			/
			(SELECT CAST(COUNT(model) AS NUMERIC(6,2)) FROM Product WHERE maker = P.maker GRoup by maker) 
			* 100
			), 0)
			AS NUMERIC(6,2)
		) as prc
FROM Product P, (SELECT DISTINCT type
FROM Product) as a
------------------------------------------------------------------------------------------- */
/* Задание: 59 (Serge I: 2003-02-15)
Посчитать остаток денежных средств на каждом пункте приема 
для базы данных с отчетностью не чаще одного раза в день. 
Вывод: пункт, остаток.
--Join--GROUP BY--CASE--NULL в условиях поиска---
-------------------------------------------------------------------------------------------
SELECT point, SUM(Remain) FROM(
	SELECT point, COALESCE(inc, 0) as Remain FROM Income_o
	UNION ALL
	SELECT point, (COALESCE(out, 0) * -1) as Remain FROM Outcome_o
) AS a 
GROUP by point
-------------------------------------------------------------------------------------------*/
/* Задание: 60 (Serge I: 2003-02-15)
Посчитать остаток денежных средств на начало дня 15/04/01 
на каждом пункте приема для базы данных с отчетностью не 
чаще одного раза в день. Вывод: пункт, остаток.
Замечание. Не учитывать пункты, информации о которых нет 
до указанной даты.
--Join--GROUP BY--CASE--NULL в условиях поиска---
-------------------------------------------------------------------------------------------
SELECT point, SUM(Remain) FROM(
	SELECT point, date, COALESCE(inc, 0) as Remain FROM Income_o
	UNION ALL
	SELECT point, date, (COALESCE(out, 0) * -1) as Remain FROM Outcome_o
) AS a 
WHERE date < '2001-04-14'
GROUP by point
------------------------------------------------------------------------------------------- */
