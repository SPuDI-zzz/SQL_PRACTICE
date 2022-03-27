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
GROUP BY cls.title
ORDER BY 2;

/*21.Для каждого класса вывести количество персонажей с короткими именами (менее 5 букв). Результат отсортировать по названию в лексикографическом порядке.*/
SELECT COUNT(chr.id) 'количество персонажей'
FROM characters chr
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY cls.title
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
GROUP BY cls.title
HAVING COUNT(chr.player_id) > 3;

/*24.Выбрать название оружия количество, ник игрока, количество персонажей с данным оружием у игрока.*/
SELECT wpn.title 'название оружия', COUNT(wpn.id) 'количество', plr.nickname, COUNT(chr.id) AS 'количество персонажей с данным оружием у игрока'
FROM characters chr
	JOIN players plr ON (chr.player_id = plr.id)
	JOIN character_weapon chr_wpn ON (chr_wpn.character_id = chr.id)
	JOIN weapons wpn ON (chr_wpn.weapon_id = wpn.id)
GROUP BY wpn.title, plr.nickname;

/*25.Для каждого игрока выбрать количество персонажей для каждого класса. Результат отсортировать по нику игроков в лексикографическом порядке.*/  
SELECT plr.nickname, COUNT(chr.id) AS 'количество персонажей для каждого класса'
FROM characters chr
	JOIN players plr ON (chr.player_id = plr.id)
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY plr.nickname, chr.class_id
ORDER BY plr.nickname;

