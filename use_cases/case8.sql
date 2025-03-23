-- Cписок покупателей, у которых суммарная стоимость покупок превышает среднее значение по всем покупателям. 

select
	first_name,
	last_name,
	total_spent
from
	(
	select
		c.customer_id,
		c.first_name,
		c.last_name,
		SUM(t.price) as total_spent
	from
		customers c
	join tickets t on
		c.customer_id = t.customer_id
	group by
		c.customer_id,
		c.first_name,
		c.last_name
	)
where
	total_spent > 
	(
		select
			AVG(customer_total)
		from
			(
			select
				SUM(t.price) as customer_total
			from
				customers c
				join tickets t on
				c.customer_id = t.customer_id
			group by
				c.customer_id
     ) as totals
)
order by
	total_spent desc;


/*
first_name|last_name|total_spent|
----------+---------+-----------+
Emily     |Johnson  |       1215|
Isabella  |Thomas   |       1125|
Abigail   |Lee      |       1115|
Grace     |Green    |       1105|
Sofia     |Young    |       1095|
Daniel    |Walker   |       1020|
William   |Anderson |        895|
Ella      |Wright   |        890|
Amelia    |Garcia   |        885|
James     |Jackson  |        875|
Ava       |Taylor   |        875|
Charlotte |Martin   |        870|
Mia       |White    |        845|
Ethan     |Wilson   |        820|
Olivia    |Miller   |        805|
*/