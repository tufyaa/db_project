-- Общая выручка площадки за всё время

select
	v.venue_name,
	SUM(t.price) as total_revenue
from
	venues v
	join events e on
		v.venue_id = e.venue_id
	join tickets t on
		e.event_id = t.event_id
	where
		t.purchase_date is not null
group by
	v.venue_name
order by
	total_revenue desc;


/*
venue_name              |total_revenue|
------------------------+-------------+
Royal Albert Hall       |         1540|
T-Mobile Arena          |         1350|
Ziggo Dome              |         1320|
Foro Sol                |         1150|
Tokyo Dome              |         1140|
Staples Center          |         1010|
Spark Arena             |          955|
Estadio Nacional        |          950|
Ahoy Rotterdam          |          940|
Accor Arena             |          910|
Oslo Spektrum           |          870|
Mercedes-Benz Arena     |          835|
Allianz Arena           |          800|
Scotiabank Arena        |          775|
WiZink Center           |          750|
O2 Academy Brixton      |          725|
Barclays Center         |          725|
Red Rocks               |          685|
The O2                  |          660|
Qudos Bank Arena        |          655|
Budapest Arena          |          645|
Rod Laver Arena         |          600|
Hollywood Bowl          |          585|
Bell Centre             |          575|
Singapore Indoor Stadium|          555|
FNB Stadium             |          450|
Hartwall Arena          |          420|
Manchester Arena        |          405|
Palau Sant Jordi        |          405|
Sydney Opera House      |          400|
*/