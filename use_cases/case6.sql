-- Сколько каждый покупатель потратил в 2024 году

select
	c.first_name,
	c.last_name,
	SUM(t.price) as total_spent
from
	customers c
	join tickets t on
			c.customer_id = t.customer_id
	where
			extract(year from t.purchase_date) = 2024
	group by
		c.customer_id
order by
	total_spent desc;


/*
first_name|last_name|total_spent|
----------+---------+-----------+
William   |Anderson |        895|
Ava       |Taylor   |        660|
Ethan     |Wilson   |        630|
Olivia    |Miller   |        550|
Charlotte |Martin   |        370|
Sophia    |Brown    |        300|
Isabella  |Thomas   |        255|
James     |Jackson  |        225|
Amelia    |Garcia   |        185|
Lucas     |Thompson |        170|
*/