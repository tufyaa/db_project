-- Любимый исполнитель у каждого покупателя

with cte as (
	select
		c.customer_id,
		c.first_name,
		c.last_name,
		a.artist_id,
		a.name as artist_name,
		COUNT(*) as attendances
	from
		tickets t
		join customers c on
			t.customer_id = c.customer_id
		join events e on
			t.event_id = e.event_id
		join artists a on
			e.artist_id = a.artist_id
	group by
		c.customer_id,
		a.artist_id
)
select
	first_name,
	last_name,
	artist_name,
	attendances
from
	cte a
	join (
		select
			customer_id,
			MAX(attendances) as max_attendances
		from
			cte
		group by
			customer_id
	) b 
	on
		a.customer_id = b.customer_id and a.attendances = b.max_attendances
order by 
	attendances desc;

/*
first_name|last_name|artist_name      |attendances|
----------+---------+-----------------+-----------+
Sofia     |Young    |Marshmello       |          3|
Sophia    |Brown    |Ed Sheeran       |          3|
Elijah    |Clark    |Travis Scott     |          3|
William   |Anderson |Dua Lipa         |          3|
Benjamin  |Harris   |Eminem           |          3|
Elizabeth |Hall     |SZA              |          3|
Abigail   |Lee      |Olivia Rodrigo   |          3|
Isabella  |Thomas   |The Weeknd       |          3|
Ethan     |Wilson   |Adele            |          3|
Grace     |Green    |Shawn Mendes     |          3|
Emily     |Johnson  |Khalid           |          3|
Amelia    |Garcia   |Ariana Grande    |          3|
Charlotte |Martin   |Rihanna          |          2|
Mia       |White    |Lady Gaga        |          2|
Matthew   |King     |Imagine Dragons  |          2|
Alexander |Allen    |The Chainsmokers |          2|
Michael   |Adams    |Sam Smith        |          2|
Daniel    |Walker   |Doja Cat         |          2|
Ella      |Wright   |Maroon 5         |          2|
James     |Jackson  |Bruno Mars       |          2|
Oliver    |Lewis    |Harry Styles     |          2|
Ava       |Taylor   |Coldplay         |          2|
Liam      |Smith    |Drake            |          2|
Harper    |Robinson |Kendrick Lamar   |          2|
Olivia    |Miller   |BTS              |          2|
Lucas     |Thompson |Rihanna          |          1|
Evelyn    |Rodriguez|Lana Del Rey     |          1|
Logan     |Scott    |Imagine Dragons  |          1|
Logan     |Scott    |Maroon 5         |          1|
Mason     |Martinez |Ariana Grande    |          1|
Logan     |Scott    |Twenty One Pilots|          1|
Evelyn    |Rodriguez|Travis Scott     |          1|
Lucas     |Thompson |Justin Bieber    |          1|
Mason     |Martinez |Justin Bieber    |          1|
Evelyn    |Rodriguez|Kendrick Lamar   |          1|
Noah      |Davis    |Taylor Swift     |          1|
Mason     |Martinez |Post Malone      |          1|
Noah      |Davis    |Billie Eilish    |          1|
*/