-- Количество некупленных билет для каждого мероприятия

select
	event_name,
	unsold_count
from
	(
	select
		e.event_id,
		e.event_name,
		COUNT(case when t.purchase_date is null then 1 end) 
            over (partition by e.event_id) as unsold_count, 
            row_number() over (partition by e.event_id order by e.event_id) as rn
	from
		events e
		join tickets t on
		e.event_id = t.event_id
	) as sub
where
	rn = 1
order by
	unsold_count desc;

/*
event_name           |unsold_count|
---------------------+------------+
Red Pill Blues Tour  |           3|
The Big Steppers Tour|           3|
Love On Tour         |           2|
Future Nostalgia     |           2|
Happier Than Ever    |           2|
SOS Tour             |           2|
BTS World Tour       |           2|
The Chromatica Ball  |           2|
Music of the Spheres |           2|
The Rapture Tour     |           2|
Wonder World Tour    |           2|
Anti World Tour      |           2|
Justice World Tour   |           2|
Sweetener World Tour |           2|
Its All a Blur       |           2|
Mercury World Tour   |           2|
Did You Know Tour    |           2|
Eras Tour            |           1|
Mathematics Tour     |           1|
30 Live              |           1|
After Hours Tour     |           1|
24K Magic World Tour |           1|
Twelve Carat Tour    |           1|
Astroworld Fest      |           1|
GUTS World Tour      |           1|
Scarlet Tour         |           1|
World War Joy Tour   |           1|
Mello Universe       |           1|
The Icy Tour         |           1|
Scenic Drive Tour    |           1|
Super Bowl Halftime  |           0|
Gloria the Tour      |           0|
*/