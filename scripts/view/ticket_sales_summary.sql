-- Статистика по продажам билетов для каждого события:

CREATE OR REPLACE VIEW ticket_sales_summary AS
SELECT
    e.event_id,
    e.event_name,
    COUNT(t.ticket_id) AS tickets_sold,
    SUM(t.price) AS total_revenue,
    AVG(t.price) AS avg_price
FROM
    proj.events e
    LEFT JOIN proj.tickets t ON e.event_id = t.event_id AND t.customer_id IS NOT NULL
GROUP BY
    e.event_id,
    e.event_name
ORDER BY
    total_revenue DESC;



/*
event_id|event_name           |tickets_sold|total_revenue|avg_price           |
--------+---------------------+------------+-------------+--------------------+
      25|Mello Universe       |           5|         1350|270.0000000000000000|
      29|Wonder World Tour    |           4|         1320|330.0000000000000000|
      21|GUTS World Tour      |           4|         1150|287.5000000000000000|
       9|After Hours Tour     |           4|         1140|285.0000000000000000|
      11|The Chromatica Ball  |           3|         1010|336.6666666666666667|
      17|The Big Steppers Tour|           3|          955|318.3333333333333333|
      22|Scarlet Tour         |           4|          950|237.5000000000000000|
      15|Sweetener World Tour |           4|          940|235.0000000000000000|
       1|Eras Tour            |           4|          935|233.7500000000000000|
       6|30 Live              |           4|          910|227.5000000000000000|
      27|Red Pill Blues Tour  |           3|          870|290.0000000000000000|
       8|Future Nostalgia     |           4|          835|208.7500000000000000|
      10|24K Magic World Tour |           4|          800|200.0000000000000000|
      19|Did You Know Tour    |           3|          775|258.3333333333333333|
      18|Astroworld Fest      |           4|          750|187.5000000000000000|
      13|Anti World Tour      |           4|          725|181.2500000000000000|
       7|Music of the Spheres |           4|          725|181.2500000000000000|
      12|The Rapture Tour     |           4|          660|165.0000000000000000|
      30|Gloria the Tour      |           3|          655|218.3333333333333333|
       5|BTS World Tour       |           3|          645|215.0000000000000000|
      31|Scenic Drive Tour    |           4|          605|151.2500000000000000|
      24|World War Joy Tour   |           3|          600|200.0000000000000000|
       4|Happier Than Ever    |           3|          585|195.0000000000000000|
      26|Mercury World Tour   |           3|          575|191.6666666666666667|
      14|Justice World Tour   |           2|          555|277.5000000000000000|
       2|Its All a Blur       |           3|          535|178.3333333333333333|
      20|Love On Tour         |           3|          450|150.0000000000000000|
      28|The Icy Tour         |           3|          420|140.0000000000000000|
      16|Twelve Carat Tour    |           3|          405|135.0000000000000000|
      23|SOS Tour             |           4|          405|101.2500000000000000|
       3|Mathematics Tour     |           4|          400|100.0000000000000000|
      32|Super Bowl Halftime  |           1|          150|150.0000000000000000|
*/