USE [Computer game];

/* 1. Выбрать все данные об оружие. Результат отсортировать по дальнобойности в порядке возрастания.*/
SELECT *
FROM weapons
ORDER BY attack_range;

/* 2. Выбрать название оружия, дальнобойность, скорость атаки. Результат отсортировать по названию в порядке обратном лексикографическому.*/
SELECT title, attack_range, attack_speed 
FROM weapons
ORDER BY title DESC;

/* 3. Выбрать все данные об игроках, для которых ник совпадает или с логином или с паролем.*/
SELECT *
FROM players
WHERE nickname = login OR nickname = password;

/* 4. Выбрать ник и логин игроков в одном столбце. В результат включить только тех игроков, для которых не указан e-mail или телефон, но указан номер карты. 
Результат отсортировать по длине ника.*/
SELECT nickname + ' ' + login
FROM players
WHERE mail IS NULL OR phone IS NULL AND card IS NOT NULL; 

/* 5. Выбрать данные классов персонажей, в названии которых присутствует 'на' или название состоит строго из двух слов.*/
SELECT *
FROM classes
WHERE title LIKE '%на%' or title LIKE '% %' AND title not like '_% _% _%';

/* 6. Выбрать название, описание, дальнобойность оружия. В результат должно войти оружие, id которых 1, 3, 5, 4. 
Результат отсортировать по убыванию дальнобойность и увеличению интеллекта.*/
SELECT title, description, attack_range
FROM weapons
WHERE id IN (1, 3, 5, 4)
ORDER BY attack_range DESC, increasing_the_attribute;

/* 7. Выбрать данные о классах персонажей, id которых лежит в диапазоне от 3 до 10.*/
SELECT *
FROM characters
WHERE id BETWEEN 3 AND 10;

/* 8. Выбрать персонажей, в описании которых есть символ _, но нет цифр.*/
SELECT *
FROM characters
WHERE story LIKE '%@_%'ESCAPE'@' AND story NOT LIKE '%[0-9]%';

/* 9. Выбрать все данные и возраст игроков. Результат отсортировать по году рождения в возрастающем порядке, по месяцу рождения в убывающем порядке
и по нику в лексикографическом порядке.*/
SELECT *, YEAR(birthday)
FROM players
ORDER BY YEAR(birthday), MONTH(birthday) DESC;

/* 10.Выбрать данные о персонажах, класс которых не определен и описание которых состоит из нескольких слов, и среди этих слов нет союза и.*/
SELECT *
FROM characters
WHERE class_id IS NULL AND LEN(story)-LEN(REPLACE(story,' ',''))+1>1 AND story NOT LIKE '% и %';

/* 11.Выбрать все данные игроков. В последнем столбце результирующей таблице указать сообщение 'Несовершеннолетний', если игроку нет 18 лет.*/
SELECT *,
CASE 
	WHEN (DATEDIFF(YEAR,birthday, GETDATE())) < 18 THEN 'Несовершеннолетний' 
	ELSE '' 
END
FROM players;

/*12.Выбрать общее количество персонажей.*/
SELECT COUNT(*) 'number of characters'
FROM characters;

/*13.Выбрать минимальный и максимальный уровень интеллекта оружия.*/
SELECT MIN(increasing_the_attribute) 'min weapon intelligence lvl ', MAX(increasing_the_attribute) 'max weapon intelligence lvl'
FROM weapons;

/*14.Выбрать средний возраст игроков.*/
SELECT AVG(CASE 
		       WHEN (MONTH(birthday)>=MONTH(GETDATE())
                     AND  DAY(birthday)>DAY(GETDATE())) 
			   THEN DATEDIFF(year, birthday,GETDATE()) - 1
               ELSE DATEDIFF(year, birthday,GETDATE()) 
           end) 'средний возраст игроков'
FROM players;

/*15.Выбрать количество игроков с двойной фамилией.*/
SELECT nickname
FROM players
WHERE nickname LIKE '%-%';

/*16.Выбрать количество игроков, логин которых совпадает с email.*/
SELECT COUNT(*) 'количество игроков'
FROM players
WHERE login = mail;

/*17.Выбрать название класса, имя персонажа и его описание.*/
SELECT cls.title, chr.name, cls.description
FROM characters chr JOIN classes cls ON chr.class_id = cls.id

/*18.Выбрать ник игрока, название класса, имя персонажа, характеристики, название оружия и степень заряда. Результат отсортировать по нику в порядке обратном лексикографическому, по имени персонажа в лексикографическом порядке.*/
SELECT plr.nickname, cls.title, chr.name, chr.stamina, chr.strength, chr.agility, chr.intellect, chr_wpn.weapon_streangth
FROM characters chr 
	JOIN players plr ON (chr.player_id = plr.id) 
	JOIN classes cls ON (chr.class_id = cls.id)
	JOIN character_weapon chr_wpn ON (chr.id = chr_wpn.character_id)
	JOIN weapons wpn ON (wpn.id = chr_wpn.weapon_id)
ORDER BY 1 DESC, 3;

/*19.Выбрать всех персонажей, принадлежащих какому-то определенному классу (подставьте название класса сами).*/
SELECT chr.name
FROM characters chr
	JOIN classes cls ON (chr.class_id = cls.id)
WHERE cls.title = 'zzz';

/*20.Выбрать название класса и количество персонажей соответствующего класса. Результат отсортировать по количеству в порядке возрастания.*/
SELECT cls.title, COUNT(chr.id)
FROM characters chr
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY cls.id, cls.title
ORDER BY 2;

/*21.Для каждого класса вывести количество персонажей с короткими именами (менее 5 букв). Результат отсортировать по названию в лексикографическом порядке.*/
SELECT COUNT(chr.id) 'количество персонажей'
FROM characters chr
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY cls.id, cls.title
HAVING LEN(cls.title) < 5
ORDER BY cls.title;

/*22.Выбрать все даты из таблицы игроки. В первом столбце вывести дату в формате: название дня недели число название месяца четыре цифры года, а во втором столбце для суббот и воскресений – “выходной”, а для остальных дней “рабочий день”.*/
SELECT DATENAME(DW,birthday) + ' ' + DATENAME(DD,birthday) + ' ' + DATENAME(MM,birthday) + ' ' + DATENAME(YYYY, birthday) 'Дата', CASE WHEN DATEPART(DW,birthday) > 5 THEN 'выходной' ELSE 'рабочий день' END 'a' 
FROM players

/*23.Выбрать названия классов, в которых более трех игроков.*/
SELECT cls.title
FROM characters chr
	JOIN classes cls ON chr.class_id = cls.id
	JOIN players plr ON chr.player_id = plr.id
GROUP BY cls.id, cls.title
HAVING COUNT(chr.player_id) > 3;

/*24.Выбрать название оружия количество, ник игрока, количество персонажей с данным оружием у игрока.*/
SELECT wpn.title 'название оружия', COUNT(wpn.id) 'количество', plr.nickname, COUNT(chr.id) 'количество персонажей с данным оружием у игрока'
FROM characters chr
	JOIN players plr ON (chr.player_id = plr.id)
	JOIN character_weapon chr_wpn ON (chr_wpn.character_id = chr.id)
	JOIN weapons wpn ON (chr_wpn.weapon_id = wpn.id)
GROUP BY wpn.id, wpn.title, plr.id, plr.nickname;

/*25.Для каждого игрока выбрать количество персонажей для каждого класса. Результат отсортировать по нику игроков в лексикографическом порядке.*/  
SELECT plr.nickname, COUNT(chr.id) 'количество персонажей для каждого класса'
FROM characters chr
	JOIN players plr ON (chr.player_id = plr.id)
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY plr.id, plr.nickname, chr.class_id
ORDER BY plr.nickname;

/*26.Выбрать все данные рожденных зимой игроков, у которых персонажи двух или трех классов.*/
SELECT plr.*
FROM players plr
	JOIN characters chr ON plr.id = chr.player_id
	JOIN classes cls ON cls.id = chr.class_id
WHERE MONTH(plr.birthday) IN (12, 1, 2)
GROUP BY plr.id, plr.birthday, plr.card, plr.login, plr.mail, plr.nickname, plr.password, plr.phone, plr.rat_group
HAVING COUNT(chr.class_id) IN (2, 3);

/*27.Для каждого класса персонажей вывести количество персонажей с id более какого-то конкретного значения (значение придумайте сами).
В результат включить только те классы оружия, в которых более двух различных персонажей.*/
SELECT COUNT(chr.class_id) 'количество персонажей с id более какого-то конкретного значения'
FROM classes cls
	JOIN characters chr ON cls.id = chr.class_id
	--JOIN character_weapon chr_wpn ON chr.id = chr_wpn.character_id
	--JOIN weapons wpn ON wpn.id = chr_wpn.weapon_id
WHERE chr.id > 2
GROUP BY cls.id
HAVING COUNT(chr.player_id) > 2;

/*28.Выбрать ник и логин игроков, имя персонажа, максимальную и минимальную степень заряда оружия с дальнобойностью больше N (значение подставьте сами).
Учитывать только персонажей, у которых два различных оружия и более. Результат отсортировать по логину в порядке обратном лексикографическому.*/
SELECT plr.nickname, plr.login, chr.name, MAX(chr_wpn.weapon_streangth) 'максимальную степень заряда оружия', MIN(chr_wpn.weapon_streangth) 'минимальную степень заряда оружия'
FROM players plr
	JOIN characters chr ON plr.id = chr.player_id
	JOIN character_weapon chr_wpn ON chr.id = chr_wpn.character_id
	JOIN weapons wpn ON wpn.id = chr_wpn.weapon_id
WHERE wpn.attack_range > 100
GROUP BY plr.id, plr.nickname, plr.login, chr.id, chr.name
HAVING COUNT(chr_wpn.weapon_id) >= 2
ORDER BY 2 DESC;

/*29.Для каждого года вывести количество рожденных в этот год игроков по временам года.
В выборке должно быть шесть столбцов: год, четыре столбца с названием времен года, количество рожденных за год. Результат отсортировать по году.*/
SELECT YEAR(birthday) 'Год рождения', COUNT(CASE WHEN MONTH(birthday) IN (12, 1, 2)THEN 1 ELSE NUll END) 'Зима', 
									  COUNT(CASE WHEN MONTH(birthday) IN (3, 4, 5)THEN 1 ELSE NUll END) 'Весна',
									  COUNT(CASE WHEN MONTH(birthday) IN (6, 7, 8)THEN 1 ELSE NUll END) 'Лето',
									  COUNT(CASE WHEN MONTH(birthday) IN (9, 10, 11)THEN 1 ELSE NUll END) 'Осень',
									  COUNT(YEAR(birthday)) 'Количество рожденных за год'
FROM players
GROUP BY YEAR(birthday)
ORDER BY 1;

/*30.Выбрать ник, логин игрока, количество персонажей у игрока. В результат включить только игроков, у которых все персонажи одного класса.
Результат отсортировать по убыванию количества персонажей и по возрастанию id_игрока.*/
SELECT plr.nickname, plr.login, COUNT(chr.id) 'количество персонажей у игрока'
FROM players plr
	JOIN characters chr ON plr.id = chr.player_id
	JOIN classes cls ON cls.id = chr.class_id
GROUP BY plr.id, plr.nickname, plr.login
HAVING MAX(class_id) = MIN(class_id)
ORDER BY 3 DESC, plr.id;

/*31.Выбрать все имена персонажей, и если персонаж есть у игрока, то ник игрока. Учесть, что могут быть персонажи без игроков.*/
SELECT chr.name, plr.nickname
FROM characters chr
	LEFT JOIN players plr ON plr.id = chr.player_id;

/*32.Выбрать названия всех классов, и если есть персонажи соответствующего класса, то имя персонажа и ник игроков, у которых есть этот персонаж.
Результат отсортировать по названию класса.*/
SELECT cls.title, chr.name, plr.nickname
FROM classes cls 
	LEFT JOIN characters chr ON cls.id = chr.class_id AND chr.player_id IS NOT NULL	
	LEFT JOIN players plr ON plr.id = chr.player_id
ORDER BY 1;

/*33.Выбрать для каждого игрока названия всех классов персонажей. Результат отсортировать по названию класса и по нику в лексикографическом порядке.*/
SELECT plr.id, plr.nickname, cls.title
FROM players plr
	CROSS JOIN classes cls 
ORDER BY 3, 2;

/*34.Выбрать для каждого игрока названия всех классов персонажей. Если у игрока есть персонаж соответствующего класса в последнем столбце результирующей таблицы поставить +.
Результат отсортировать по названию класса и по нику в лексикографическом порядке.*/
SELECT DISTINCT plr.id, plr.nickname, cls.title, CASE WHEN chr.class_id IS NULL THEN '' ELSE '+' END 'есть ли персонаж соответствующего класса'
FROM players plr
	CROSS JOIN classes cls
	LEFT JOIN characters chr ON cls.id = chr.class_id AND chr.player_id = plr.id
ORDER BY 3, 2;

/*35.Выбрать название всех классов персонажей и количество персонажей. Учесть, что в базе может не быть персонажей кого-либо класс.*/
SELECT cls.title, COUNT(chr.id) 'количество персонажей'
FROM classes cls
	LEFT JOIN characters chr ON cls.id = chr.class_id
GROUP BY cls.id, cls.title;

/*36.Найти пары игроков, у которых совпадает пароль.*/
SELECT plr.id, plr.nickname, p.id, p.nickname
FROM players plr
	JOIN players p ON plr.password = p.password
WHERE plr.id > p.id;

/*37.Вывести пары персонажей из одного клана, чьи имена начинаются на одну букву. Результат отсортировать по названию класса и по имени в лексикографическом порядке.*/
SELECT chr.id, chr.name, c.id, c.name
FROM characters chr 
	JOIN characters c ON chr.clan = c.clan
WHERE chr.id > c.id AND LEFT(chr.name,1) = LEFT(c.name,1); 

/*38.Выбрать трех самых младших игроков.*/
SELECT TOP 3 id, nickname, birthday
FROM players plr
ORDER BY birthday DESC;

/*39.Вывести сообщение ‘Два игрока указали один email’, если есть такая пара игроков, у которой один и тот же email. И вывести вcе email уникальны в противном случае.*/
SELECT CASE WHEN COUNT(*) > 0 THEN 'Два игрока указали один email' ELSE 'вcе email уникальны' END 'email'
FROM players plr
	JOIN players p ON plr.mail = p.mail
WHERE plr.id > p.id;

/*40.Выбрать все данные о самом молодом игроке.*/
SELECT *
FROM players plr
WHERE 0 = (SELECT COUNT(*)
			FROM players p
			WHERE p.birthday > plr.birthday);

/*41.Выбрать все данные о самом молодом и о самом старшем игроке.*/
SELECT *
FROM players
WHERE birthday IN (SELECT MIN(birthday)
				   FROM players
				   UNION ALL
				   SELECT MAX(birthday)
				   FROM players)

/*42.Выбрать названия классов, в которых нет игроков.*/
SELECT title
FROM classes
WHERE id NOT IN (SELECT DISTINCT ISNULL(class_id,0)
				 FROM characters
				 WHERE player_id IS NOT NULL);

/*43.Выбрать ник и логин игрока, который обладает всеми видами оружия.*/
SELECT plr.nickname, plr.login
FROM players plr
	JOIN characters chr ON plr.id = chr.player_id
	JOIN character_weapon chr_wpn ON chr.id = chr_wpn.character_id
	JOIN weapons wpn ON wpn.id = chr_wpn.weapon_id
GROUP BY plr.id, plr.nickname, plr.login
HAVING COUNT(wpn.id) > 0

SELECT COUNT(id)
FROM weapons

SELECT character_id, COUNT(DISTINCT weapon_id)
FROM character_weapon
GROUP BY character_id

SELECT plr.nickname, plr.login
FROM players plr
WHERE plr.id IN (SELECT chr.player_id
				 FROM characters chr
				 WHERE chr.id IN (SELECT chr_wpn.character_id
								  FROM character_weapon chr_wpn
								  GROUP BY chr_wpn.character_id
								  HAVING SUM(SELECT COUNT(DISTINCT weapon_id)
								  FROM character_weapon
								  WHERE 
								  GROUP BY character_id)
								  COUNT(DISTINCT chr_wpn.weapon_id)) = (SELECT COUNT(*)
																			  FROM weapons wpn)))

SELECT plr.nickname, plr.login
FROM players plr
GROUP BY plr.id, plr.nickname, plr.login
HAVING SUM() = (SELECT COUNT(*) FROM weapons)

/*44.Выбрать для каждого класса персонажа, имеющего минимальную степень заряда оружия среди всех персонажей этого класса.*/

/*45.Выбрать игрока, у которого максимальное количество персонажей.*/
SELECT id
FROM players
WHERE id IN (SELECT player_id
FROM characters
GROUP BY player_id)

SELECT COUNT(id)
FROM characters
WHERE player_id IS NOT NULL
GROUP BY player_id

SELECT TOP 1 WITH TIES p.id
FROM players p
UNION
SELECT c.player_id
FROM characters c
WHERE c.player_id IS NOT NULL

/*46.Выбрать название класса, в котором минимальное количество персонажей. Учесть, что может быть класс без персонажей.*/

/*47.Выбрать все данные игроков, у персонажей которых есть не все виды оружия. В результат должны войти игроки, у которых есть персонажи из всех классов.*/

/*48.Выбрать названия все описания из БД. Результат отсортировать в лексикографическом порядке.*/

/*49.Выбрать все классы, в которых есть персонажи с одинаковым описанием.*/

/*50.Вывести название оружия, которое есть у наибольшего числа персонажей.*/
