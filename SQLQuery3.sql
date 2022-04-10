USE [Computer game];

/* 1. ������� ��� ������ �� ������. ��������� ������������� �� �������������� � ������� �����������.*/
SELECT *
FROM weapons
ORDER BY attack_range;

/* 2. ������� �������� ������, ��������������, �������� �����. ��������� ������������� �� �������� � ������� �������� �������������������.*/
SELECT title, attack_range, attack_speed 
FROM weapons
ORDER BY title DESC;

/* 3. ������� ��� ������ �� �������, ��� ������� ��� ��������� ��� � ������� ��� � �������.*/
SELECT *
FROM players
WHERE nickname = login OR nickname = password;

/* 4. ������� ��� � ����� ������� � ����� �������. � ��������� �������� ������ ��� �������, ��� ������� �� ������ e-mail ��� �������, �� ������ ����� �����. 
��������� ������������� �� ����� ����.*/
SELECT nickname + ' ' + login
FROM players
WHERE mail IS NULL OR phone IS NULL AND card IS NOT NULL; 

/* 5. ������� ������ ������� ����������, � �������� ������� ������������ '��' ��� �������� ������� ������ �� ���� ����.*/
SELECT *
FROM classes
WHERE title LIKE '%��%' or title LIKE '% %' AND title not like '_% _% _%';

/* 6. ������� ��������, ��������, �������������� ������. � ��������� ������ ����� ������, id ������� 1, 3, 5, 4. 
��������� ������������� �� �������� �������������� � ���������� ����������.*/
SELECT title, description, attack_range
FROM weapons
WHERE id IN (1, 3, 5, 4)
ORDER BY attack_range DESC, increasing_the_attribute;

/* 7. ������� ������ � ������� ����������, id ������� ����� � ��������� �� 3 �� 10.*/
SELECT *
FROM characters
WHERE id BETWEEN 3 AND 10;

/* 8. ������� ����������, � �������� ������� ���� ������ _, �� ��� ����.*/
SELECT *
FROM characters
WHERE story LIKE '%@_%'ESCAPE'@' AND story NOT LIKE '%[0-9]%';

/* 9. ������� ��� ������ � ������� �������. ��������� ������������� �� ���� �������� � ������������ �������, �� ������ �������� � ��������� �������
� �� ���� � ������������������ �������.*/
SELECT *, YEAR(birthday)
FROM players
ORDER BY YEAR(birthday), MONTH(birthday) DESC;

/* 10.������� ������ � ����������, ����� ������� �� ��������� � �������� ������� ������� �� ���������� ����, � ����� ���� ���� ��� ����� �.*/
SELECT *
FROM characters
WHERE class_id IS NULL AND LEN(story)-LEN(REPLACE(story,' ',''))+1>1 AND story NOT LIKE '% � %';

/* 11.������� ��� ������ �������. � ��������� ������� �������������� ������� ������� ��������� '������������������', ���� ������ ��� 18 ���.*/
SELECT *,
CASE 
	WHEN (DATEDIFF(YEAR,birthday, GETDATE())) < 18 THEN '������������������' 
	ELSE '' 
END
FROM players;

/*12.������� ����� ���������� ����������.*/
SELECT COUNT(*) 'number of characters'
FROM characters;

/*13.������� ����������� � ������������ ������� ���������� ������.*/
SELECT MIN(increasing_the_attribute) 'min weapon intelligence lvl ', MAX(increasing_the_attribute) 'max weapon intelligence lvl'
FROM weapons;

/*14.������� ������� ������� �������.*/
SELECT AVG(CASE 
		       WHEN (MONTH(birthday)>=MONTH(GETDATE())
                     AND  DAY(birthday)>DAY(GETDATE())) 
			   THEN DATEDIFF(year, birthday,GETDATE()) - 1
               ELSE DATEDIFF(year, birthday,GETDATE()) 
           end) '������� ������� �������'
FROM players;

/*15.������� ���������� ������� � ������� ��������.*/
SELECT nickname
FROM players
WHERE nickname LIKE '%-%';

/*16.������� ���������� �������, ����� ������� ��������� � email.*/
SELECT COUNT(*) '���������� �������'
FROM players
WHERE login = mail;

/*17.������� �������� ������, ��� ��������� � ��� ��������.*/
SELECT cls.title, chr.name, cls.description
FROM characters chr JOIN classes cls ON chr.class_id = cls.id

/*18.������� ��� ������, �������� ������, ��� ���������, ��������������, �������� ������ � ������� ������. ��������� ������������� �� ���� � ������� �������� �������������������, �� ����� ��������� � ������������������ �������.*/
SELECT plr.nickname, cls.title, chr.name, chr.stamina, chr.strength, chr.agility, chr.intellect, chr_wpn.weapon_streangth
FROM characters chr 
	JOIN players plr ON (chr.player_id = plr.id) 
	JOIN classes cls ON (chr.class_id = cls.id)
	JOIN character_weapon chr_wpn ON (chr.id = chr_wpn.character_id)
	JOIN weapons wpn ON (wpn.id = chr_wpn.weapon_id)
ORDER BY 1 DESC, 3;

/*19.������� ���� ����������, ������������� ������-�� ������������� ������ (���������� �������� ������ ����).*/
SELECT chr.name
FROM characters chr
	JOIN classes cls ON (chr.class_id = cls.id)
WHERE cls.title = 'zzz';

/*20.������� �������� ������ � ���������� ���������� ���������������� ������. ��������� ������������� �� ���������� � ������� �����������.*/
SELECT cls.title, COUNT(chr.id)
FROM characters chr
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY cls.id, cls.title
ORDER BY 2;

/*21.��� ������� ������ ������� ���������� ���������� � ��������� ������� (����� 5 ����). ��������� ������������� �� �������� � ������������������ �������.*/
SELECT COUNT(chr.id) '���������� ����������'
FROM characters chr
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY cls.id, cls.title
HAVING LEN(cls.title) < 5
ORDER BY cls.title;

/*22.������� ��� ���� �� ������� ������. � ������ ������� ������� ���� � �������: �������� ��� ������ ����� �������� ������ ������ ����� ����, � �� ������ ������� ��� ������ � ����������� � ���������, � ��� ��������� ���� �������� �����.*/
SELECT DATENAME(DW,birthday) + ' ' + DATENAME(DD,birthday) + ' ' + DATENAME(MM,birthday) + ' ' + DATENAME(YYYY, birthday) '����', CASE WHEN DATEPART(DW,birthday) > 5 THEN '��������' ELSE '������� ����' END 'a' 
FROM players

/*23.������� �������� �������, � ������� ����� ���� �������.*/
SELECT cls.title
FROM characters chr
	JOIN classes cls ON chr.class_id = cls.id
	JOIN players plr ON chr.player_id = plr.id
GROUP BY cls.id, cls.title
HAVING COUNT(chr.player_id) > 3;

/*24.������� �������� ������ ����������, ��� ������, ���������� ���������� � ������ ������� � ������.*/
SELECT wpn.title '�������� ������', COUNT(wpn.id) '����������', plr.nickname, COUNT(chr.id) '���������� ���������� � ������ ������� � ������'
FROM characters chr
	JOIN players plr ON (chr.player_id = plr.id)
	JOIN character_weapon chr_wpn ON (chr_wpn.character_id = chr.id)
	JOIN weapons wpn ON (chr_wpn.weapon_id = wpn.id)
GROUP BY wpn.id, wpn.title, plr.id, plr.nickname;

/*25.��� ������� ������ ������� ���������� ���������� ��� ������� ������. ��������� ������������� �� ���� ������� � ������������������ �������.*/  
SELECT plr.nickname, COUNT(chr.id) '���������� ���������� ��� ������� ������'
FROM characters chr
	JOIN players plr ON (chr.player_id = plr.id)
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY plr.id, plr.nickname, chr.class_id
ORDER BY plr.nickname;

/*26.������� ��� ������ ��������� ����� �������, � ������� ��������� ���� ��� ���� �������.*/
SELECT plr.*
FROM players plr
	JOIN characters chr ON plr.id = chr.player_id
	JOIN classes cls ON cls.id = chr.class_id
WHERE MONTH(plr.birthday) IN (12, 1, 2)
GROUP BY plr.id, plr.birthday, plr.card, plr.login, plr.mail, plr.nickname, plr.password, plr.phone, plr.rat_group
HAVING COUNT(chr.class_id) IN (2, 3);

/*27.��� ������� ������ ���������� ������� ���������� ���������� � id ����� ������-�� ����������� �������� (�������� ���������� ����).
� ��������� �������� ������ �� ������ ������, � ������� ����� ���� ��������� ����������.*/
SELECT COUNT(chr.class_id) '���������� ���������� � id ����� ������-�� ����������� ��������'
FROM classes cls
	JOIN characters chr ON cls.id = chr.class_id
	--JOIN character_weapon chr_wpn ON chr.id = chr_wpn.character_id
	--JOIN weapons wpn ON wpn.id = chr_wpn.weapon_id
WHERE chr.id > 2
GROUP BY cls.id
HAVING COUNT(chr.player_id) > 2;

/*28.������� ��� � ����� �������, ��� ���������, ������������ � ����������� ������� ������ ������ � ��������������� ������ N (�������� ���������� ����).
��������� ������ ����������, � ������� ��� ��������� ������ � �����. ��������� ������������� �� ������ � ������� �������� �������������������.*/
SELECT plr.nickname, plr.login, chr.name, MAX(chr_wpn.weapon_streangth) '������������ ������� ������ ������', MIN(chr_wpn.weapon_streangth) '����������� ������� ������ ������'
FROM players plr
	JOIN characters chr ON plr.id = chr.player_id
	JOIN character_weapon chr_wpn ON chr.id = chr_wpn.character_id
	JOIN weapons wpn ON wpn.id = chr_wpn.weapon_id
WHERE wpn.attack_range > 100
GROUP BY plr.id, plr.nickname, plr.login, chr.id, chr.name
HAVING COUNT(chr_wpn.weapon_id) >= 2
ORDER BY 2 DESC;

/*29.��� ������� ���� ������� ���������� ��������� � ���� ��� ������� �� �������� ����.
� ������� ������ ���� ����� ��������: ���, ������ ������� � ��������� ������ ����, ���������� ��������� �� ���. ��������� ������������� �� ����.*/
SELECT YEAR(birthday) '��� ��������', COUNT(CASE WHEN MONTH(birthday) IN (12, 1, 2)THEN 1 ELSE NUll END) '����', 
									  COUNT(CASE WHEN MONTH(birthday) IN (3, 4, 5)THEN 1 ELSE NUll END) '�����',
									  COUNT(CASE WHEN MONTH(birthday) IN (6, 7, 8)THEN 1 ELSE NUll END) '����',
									  COUNT(CASE WHEN MONTH(birthday) IN (9, 10, 11)THEN 1 ELSE NUll END) '�����',
									  COUNT(YEAR(birthday)) '���������� ��������� �� ���'
FROM players
GROUP BY YEAR(birthday)
ORDER BY 1;

/*30.������� ���, ����� ������, ���������� ���������� � ������. � ��������� �������� ������ �������, � ������� ��� ��������� ������ ������.
��������� ������������� �� �������� ���������� ���������� � �� ����������� id_������.*/
SELECT plr.nickname, plr.login, COUNT(chr.id) '���������� ���������� � ������'
FROM players plr
	JOIN characters chr ON plr.id = chr.player_id
	JOIN classes cls ON cls.id = chr.class_id
GROUP BY plr.id, plr.nickname, plr.login
HAVING MAX(class_id) = MIN(class_id)
ORDER BY 3 DESC, plr.id;

/*31.������� ��� ����� ����������, � ���� �������� ���� � ������, �� ��� ������. ������, ��� ����� ���� ��������� ��� �������.*/
SELECT chr.name, plr.nickname
FROM characters chr
	LEFT JOIN players plr ON plr.id = chr.player_id;

/*32.������� �������� ���� �������, � ���� ���� ��������� ���������������� ������, �� ��� ��������� � ��� �������, � ������� ���� ���� ��������.
��������� ������������� �� �������� ������.*/
SELECT cls.title, chr.name, plr.nickname
FROM classes cls 
	LEFT JOIN characters chr ON cls.id = chr.class_id AND chr.player_id IS NOT NULL	
	LEFT JOIN players plr ON plr.id = chr.player_id
ORDER BY 1;

/*33.������� ��� ������� ������ �������� ���� ������� ����������. ��������� ������������� �� �������� ������ � �� ���� � ������������������ �������.*/
SELECT plr.id, plr.nickname, cls.title
FROM players plr
	CROSS JOIN classes cls 
ORDER BY 3, 2;

/*34.������� ��� ������� ������ �������� ���� ������� ����������. ���� � ������ ���� �������� ���������������� ������ � ��������� ������� �������������� ������� ��������� +.
��������� ������������� �� �������� ������ � �� ���� � ������������������ �������.*/
SELECT DISTINCT plr.id, plr.nickname, cls.title, CASE WHEN chr.class_id IS NULL THEN '' ELSE '+' END '���� �� �������� ���������������� ������'
FROM players plr
	CROSS JOIN classes cls
	LEFT JOIN characters chr ON cls.id = chr.class_id AND chr.player_id = plr.id
ORDER BY 3, 2;

/*35.������� �������� ���� ������� ���������� � ���������� ����������. ������, ��� � ���� ����� �� ���� ���������� ����-���� �����.*/
SELECT cls.title, COUNT(chr.id) '���������� ����������'
FROM classes cls
	LEFT JOIN characters chr ON cls.id = chr.class_id
GROUP BY cls.id, cls.title;

/*36.����� ���� �������, � ������� ��������� ������.*/
SELECT plr.id, plr.nickname, p.id, p.nickname
FROM players plr
	JOIN players p ON plr.password = p.password
WHERE plr.id > p.id;

/*37.������� ���� ���������� �� ������ �����, ��� ����� ���������� �� ���� �����. ��������� ������������� �� �������� ������ � �� ����� � ������������������ �������.*/
SELECT chr.id, chr.name, c.id, c.name
FROM characters chr 
	JOIN characters c ON chr.clan = c.clan
WHERE chr.id > c.id AND LEFT(chr.name,1) = LEFT(c.name,1); 

/*38.������� ���� ����� ������� �������.*/
SELECT TOP 3 id, nickname, birthday
FROM players plr
ORDER BY birthday DESC;

/*39.������� ��������� ���� ������ ������� ���� email�, ���� ���� ����� ���� �������, � ������� ���� � ��� �� email. � ������� �c� email ��������� � ��������� ������.*/
SELECT CASE WHEN COUNT(*) > 0 THEN '��� ������ ������� ���� email' ELSE '�c� email ���������' END 'email'
FROM players plr
	JOIN players p ON plr.mail = p.mail
WHERE plr.id > p.id;

/*40.������� ��� ������ � ����� ������� ������.*/
SELECT *
FROM players plr
WHERE 0 = (SELECT COUNT(*)
			FROM players p
			WHERE p.birthday > plr.birthday);

/*41.������� ��� ������ � ����� ������� � � ����� ������� ������.*/
SELECT *
FROM players
WHERE birthday IN (SELECT MIN(birthday)
				   FROM players
				   UNION ALL
				   SELECT MAX(birthday)
				   FROM players)

/*42.������� �������� �������, � ������� ��� �������.*/
SELECT title
FROM classes
WHERE id NOT IN (SELECT DISTINCT ISNULL(class_id,0)
				 FROM characters
				 WHERE player_id IS NOT NULL);

/*43.������� ��� � ����� ������, ������� �������� ����� ������ ������.*/
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

/*44.������� ��� ������� ������ ���������, �������� ����������� ������� ������ ������ ����� ���� ���������� ����� ������.*/

/*45.������� ������, � �������� ������������ ���������� ����������.*/
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

/*46.������� �������� ������, � ������� ����������� ���������� ����������. ������, ��� ����� ���� ����� ��� ����������.*/

/*47.������� ��� ������ �������, � ���������� ������� ���� �� ��� ���� ������. � ��������� ������ ����� ������, � ������� ���� ��������� �� ���� �������.*/

/*48.������� �������� ��� �������� �� ��. ��������� ������������� � ������������������ �������.*/

/*49.������� ��� ������, � ������� ���� ��������� � ���������� ���������.*/

/*50.������� �������� ������, ������� ���� � ����������� ����� ����������.*/
