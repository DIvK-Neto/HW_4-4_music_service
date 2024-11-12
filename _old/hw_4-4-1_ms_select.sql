-- Задание 2
-- 2.1 выведем название и продолжительность самого длительного трека
SELECT title, duration FROM track
WHERE duration = (SELECT max(duration) FROM track);

-- 2.2 выведем название треков, продолжительность которых не менее 3,5 минут.
SELECT title, duration FROM track
WHERE duration >= 3.5*60;

-- 2.3 выведем названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title, year FROM collection
WHERE year >= 2018 and year <= 2020;

-- 2.4 выведем исполнителий, чьё имя состоит из одного слова.
SELECT name  from  artist
WHERE name NOT LIKE '% %';

-- 2.5 выведем название треков, которые содержат слово «мой» или «my».
SELECT title  from  track
WHERE 
	title LIKE '%Мой%' or
	title LIKE '%мой%' or 
	title LIKE '%My%' or 
	title LIKE '%my%'
;


-- Задание 3
-- 3.1 выведем количество исполнителей в каждом жанре
---- Вариант 1. Т.к. у нас уже есть таблица artistgenre, то можем просто в ней сгруппировать кол-во
---- исполнителей по жанрам
SELECT genre_id, COUNT(artist_id) FROM artistgenre
GROUP BY genre_id
ORDER BY genre_id;
---- данный вариант не информативный, т.к. не видим названия жанров.

---- Вариант 2. Объеденим таблицы. Данный вариант более информативный, мы увидим и id жанра, и его название, и 
---- кол-во исполнителей в жанре
SELECT g.id, g.title, COUNT(a.artist_id) FROM genre g
JOIN  artistgenre a ON g.id = a.genre_id
GROUP BY g.id
ORDER BY g.id;

-- 3.2 выведем количество треков, вошедших в альбомы 2019–2020 годов.
SELECT a.title, a.year, count(t.id) FROM album a
JOIN track t ON a.id = t.album_id
WHERE a.year >= 2019 AND a.year <= 2020
GROUP BY a.title, a.year

-- 3.3 выведем среднюю продолжительность треков по каждому альбому.
SELECT a.title, ROUND(AVG(t.duration)) FROM album a
JOIN track t ON a.id = t.album_id
GROUP BY a.title 

-- 3.4 выведем всех исполнителей, которые не выпустили альбомы в 2020 году.
SELECT ar.name, al.year FROM artist ar
JOIN artistalbum aa ON ar.id = aa.artist_id
JOIN album al ON aa.album_id = al.id
WHERE al.year != 2020

-- 3.5 выведем названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT c.title, a.year FROM collection c
JOIN collectiontrack ct ON c.id = ct.collection_id
JOIN track t ON ct.track_id= t.id
JOIN album a ON t.album_id = a.id
JOIN artistalbum aa ON a.id = aa.album_id
JOIN artist ar ON aa.artist_id= ar.id
WHERE ar.name LIKE 'Кино'


-- Задание 4 (дополнительное)
-- 4.1 выведем названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT a.title FROM album a 
JOIN artistalbum aa ON a.id = aa.album_id 
JOIN artist ar ON aa.artist_id = ar.id 
JOIN artistgenre ag ON ar.id = ag.artist_id 
JOIN genre gr ON ag.genre_id = gr.id 
GROUP BY a.title 
HAVING COUNT(DISTINCT gr.id) > 1;
 
  
-- 4.2 выведем наименования треков, которые не входят в сборники.
SELECT t.title FROM track t
LEFT JOIN collectiontrack ct ON t.id = ct.track_id
WHERE ct.track_id IS NULL

-- 4.3 выведем исполнителей или исполнителя, написавшие самый короткий по продолжительности трек 
-- (теоретически таких треков может быть несколько)
 SELECT ar.name, t.duration FROM artist ar
 JOIN artistalbum aa ON ar.id = aa.artist_id
 JOIN album a ON aa.album_id = a.id
 JOIN track t ON a.id = t.album_id
 WHERE t.duration IN (
 	SELECT MIN(duration) FROM track
 	)

-- 4.4 выведем названия альбомов, содержащих наименьшее количество треков.
 SELECT a.title, count(t.id) FROM album a
 JOIN track t ON a.id = t.album_id
 GROUP BY a.title 
 HAVING count(t.id) in (
 	SELECT count(t.id) FROM album a
    JOIN track t ON a.id = t.album_id
    GROUP BY a.title
    ORDER BY count(t.id)
    LIMIT 1
    )




