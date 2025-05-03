-- View 1: Upcoming_Events
--   Показывает все грядущие события (event_date > NOW()).

CREATE OR REPLACE VIEW upcoming_events AS
SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    v.venue_name,
    a.name AS artist_name
FROM
    events e
    JOIN venues v  ON e.venue_id  = v.venue_id
    JOIN artists a ON e.artist_id = a.artist_id
WHERE
    e.event_date > NOW()
ORDER BY
    e.event_date;


/*
event_id|event_name           |event_date             |venue_name              |artist_name    |
--------+---------------------+-----------------------+------------------------+---------------+
      12|The Rapture Tour     |2025-05-30 19:00:00.000|The O2                  |Eminem         |
      14|Justice World Tour   |2025-07-01 19:00:00.000|Singapore Indoor Stadium|Justin Bieber  |
      15|Sweetener World Tour |2025-08-10 18:00:00.000|Ahoy Rotterdam          |Ariana Grande  |
      16|Twelve Carat Tour    |2025-09-20 19:30:00.000|Palau Sant Jordi        |Post Malone    |
      17|The Big Steppers Tour|2025-10-05 20:00:00.000|Spark Arena             |Kendrick Lamar |
      18|Astroworld Fest      |2025-11-11 17:00:00.000|WiZink Center           |Travis Scott   |
      19|Did You Know Tour    |2025-12-24 19:00:00.000|Scotiabank Arena        |Lana Del Rey   |
      22|Scarlet Tour         |2026-03-08 18:30:00.000|Estadio Nacional        |Doja Cat       |
      25|Mello Universe       |2026-06-18 21:00:00.000|T-Mobile Arena          |Marshmello     |
      26|Mercury World Tour   |2026-07-07 19:00:00.000|Bell Centre             |Imagine Dragons|
      27|Red Pill Blues Tour  |2026-08-12 20:00:00.000|Oslo Spektrum           |Maroon 5       |
      29|Wonder World Tour    |2026-10-31 19:00:00.000|Ziggo Dome              |Shawn Mendes   |
      30|Gloria the Tour      |2026-11-11 20:30:00.000|Qudos Bank Arena        |Sam Smith      |
*/

