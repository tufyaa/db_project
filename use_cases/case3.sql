-- Расчёт средней цены билета по каждому событию

with event_prices as (
	select
		e.event_id,
		e.event_name,
		ROUND(AVG(t.price) over (partition by e.event_id)::numeric,2) as average_price,
		row_number() over (partition by e.event_id order by e.event_name) as rn
	from
		events e
	join tickets t on
		e.event_id = t.event_id
)
select
	event_name,
	average_price
from
	event_prices
where
	rn = 1
order by
	average_price desc;


/*
event_name           |average_price|
---------------------+-------------+
The Chromatica Ball  |       348.00|
Wonder World Tour    |       331.67|
The Big Steppers Tour|       314.17|
After Hours Tour     |       289.00|
GUTS World Tour      |       287.00|
Justice World Tour   |       278.75|
Mello Universe       |       265.00|
Red Pill Blues Tour  |       255.83|
Sweetener World Tour |       249.17|
Eras Tour            |       241.00|
Did You Know Tour    |       235.00|
Gloria the Tour      |       218.33|
Scarlet Tour         |       216.00|
30 Live              |       209.00|
World War Joy Tour   |       207.50|
BTS World Tour       |       207.00|
Happier Than Ever    |       201.00|
24K Magic World Tour |       198.00|
Future Nostalgia     |       191.67|
Astroworld Fest      |       189.00|
The Rapture Tour     |       180.83|
Anti World Tour      |       180.83|
Mercury World Tour   |       180.00|
Its All a Blur       |       169.00|
Music of the Spheres |       165.83|
Super Bowl Halftime  |       150.00|
Love On Tour         |       150.00|
Scenic Drive Tour    |       139.00|
The Icy Tour         |       132.50|
Twelve Carat Tour    |       123.75|
SOS Tour             |       103.33|
Mathematics Tour     |       103.00|
*/