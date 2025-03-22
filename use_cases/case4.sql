-- Средняя цена билета по категориям

select
	ticket_type,
	ROUND(AVG(price)::numeric,
	2) as average_price
from
	tickets
group by
	ticket_type
order by
	average_price;


/*
ticket_type|average_price|
-----------+-------------+
student    |       143.65|
           |       171.25|
standard   |       188.29|
premium    |       255.00|
vip        |       271.34|
*/