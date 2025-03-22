-- Количество мероприятий, на которых выступал каждый артист

select
	a.name as artist_name,
	COUNT(e.event_id) as events_count
from
	Artists a
	left join Events e on
		a.artist_id = e.artist_id
	group by
		a.artist_id
order by
	events_count desc,
	artist_name
limit 3;

/*
artist_name  |events_count|
-------------+------------+
Taylor Swift |           2|
Adele        |           1|
Ariana Grande|           1|
*/