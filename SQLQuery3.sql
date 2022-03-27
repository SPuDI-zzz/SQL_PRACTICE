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
GROUP BY cls.title
ORDER BY 2;

/*21.��� ������� ������ ������� ���������� ���������� � ��������� ������� (����� 5 ����). ��������� ������������� �� �������� � ������������������ �������.*/
SELECT COUNT(chr.id) '���������� ����������'
FROM characters chr
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY cls.title
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
GROUP BY cls.title
HAVING COUNT(chr.player_id) > 3;

/*24.������� �������� ������ ����������, ��� ������, ���������� ���������� � ������ ������� � ������.*/
SELECT wpn.title '�������� ������', COUNT(wpn.id) '����������', plr.nickname, COUNT(chr.id) AS '���������� ���������� � ������ ������� � ������'
FROM characters chr
	JOIN players plr ON (chr.player_id = plr.id)
	JOIN character_weapon chr_wpn ON (chr_wpn.character_id = chr.id)
	JOIN weapons wpn ON (chr_wpn.weapon_id = wpn.id)
GROUP BY wpn.title, plr.nickname;

/*25.��� ������� ������ ������� ���������� ���������� ��� ������� ������. ��������� ������������� �� ���� ������� � ������������������ �������.*/  
SELECT plr.nickname, COUNT(chr.id) AS '���������� ���������� ��� ������� ������'
FROM characters chr
	JOIN players plr ON (chr.player_id = plr.id)
	JOIN classes cls ON (chr.class_id = cls.id)
GROUP BY plr.nickname, chr.class_id
ORDER BY plr.nickname;

