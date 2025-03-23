-- Топ-5 артистов по количеству событий

select
	a.name as artist_name,
	COUNT(e.event_id) as events_count
from
	artists a
	join events e on
		a.artist_id = e.artist_id
group by
	a.name
order by
	events_count desc
limit 5;

/*
artist_name  |events_count|
-------------+------------+
Taylor Swift |           2|
Lana Del Rey |           1|
BTS          |           1|
Shawn Mendes |           1|
Ariana Grande|           1|
*/