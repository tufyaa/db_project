-- Выборка предстоящих событий с информацией об артисте и площадке

select
	e.event_name,
	e.event_date,
	a.name as artist_name,
	v.venue_name,
	v.address
from
	events e
	join artists a on
		e.artist_id = a.artist_id
	join venues v on
		e.venue_id = v.venue_id
where
	e.event_date > NOW()
order by
	e.event_date;

/*
event_name           |event_date             |artist_name    |venue_name              |address                                                 |
---------------------+-----------------------+---------------+------------------------+--------------------------------------------------------+
The Chromatica Ball  |2025-04-25 20:00:00.000|Lady Gaga      |Staples Center          |1111 S Figueroa St, Los Angeles, CA 90015               |
The Rapture Tour     |2025-05-30 19:00:00.000|Eminem         |The O2                  |Peninsula Square, London SE10 0DX                       |
Justice World Tour   |2025-07-01 19:00:00.000|Justin Bieber  |Singapore Indoor Stadium|2 Stadium Walk, Singapore 397691                        |
Sweetener World Tour |2025-08-10 18:00:00.000|Ariana Grande  |Ahoy Rotterdam          |Ahoyweg 10, 3084 BA Rotterdam                           |
Twelve Carat Tour    |2025-09-20 19:30:00.000|Post Malone    |Palau Sant Jordi        |Passeig Olímpic, 5-7, 08038 Barcelona                   |
The Big Steppers Tour|2025-10-05 20:00:00.000|Kendrick Lamar |Spark Arena             |42-80 Mahuhu Cres, Auckland CBD, Auckland 1010          |
Astroworld Fest      |2025-11-11 17:00:00.000|Travis Scott   |WiZink Center           |Av. Felipe II, s/n, 28009 Madrid                        |
Did You Know Tour    |2025-12-24 19:00:00.000|Lana Del Rey   |Scotiabank Arena        |40 Bay St, Toronto, ON M5J 2X2                          |
Scarlet Tour         |2026-03-08 18:30:00.000|Doja Cat       |Estadio Nacional        |Av. Grecia s/n, Ñuñoa, Santiago                         |
Mello Universe       |2026-06-18 21:00:00.000|Marshmello     |T-Mobile Arena          |3780 S Las Vegas Blvd, Las Vegas, NV 89158              |
Mercury World Tour   |2026-07-07 19:00:00.000|Imagine Dragons|Bell Centre             |1909 Av. des Canadiens-de-Montréal, Montréal, QC H4B 5G0|
Red Pill Blues Tour  |2026-08-12 20:00:00.000|Maroon 5       |Oslo Spektrum           |Sonja Henies plass 2, 0185 Oslo                         |
Wonder World Tour    |2026-10-31 19:00:00.000|Shawn Mendes   |Ziggo Dome              |De Passage 100, 1101 AX Amsterdam                       |
Gloria the Tour      |2026-11-11 20:30:00.000|Sam Smith      |Qudos Bank Arena        |Olympic Blvd, Sydney NSW 2127                           |
*/
