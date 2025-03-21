import psycopg2
import config as cfg


def create_tables():
    conn = psycopg2.connect(
        dbname=cfg.DB_NAME,
        user=cfg.USER_NAME,
        password=cfg.PASSWORD,
        host=cfg.HOST,
        port=cfg.PORT
    )

    cur = conn.cursor()

    try:
        cur.execute("CREATE SCHEMA IF NOT EXISTS proj;")
        cur.execute("SET search_path TO proj;")

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Artists (
                artist_id       SERIAL PRIMARY KEY,
                name            VARCHAR(20) NOT NULL,
                main_genre      VARCHAR(20),
                phone_number    VARCHAR(20) NOT NULL CHECK (phone_number ~ '^\+[0-9]{7,15}$'),
                email           VARCHAR(50) NOT NULL CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Venues (
                venue_id        SERIAL PRIMARY KEY,
                venue_name      VARCHAR(50) NOT NULL,
                address         VARCHAR(100) NOT NULL,
                capacity        INTEGER CHECK (capacity > 0),
                email           VARCHAR(50) NOT NULL CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Events (
                event_id        SERIAL PRIMARY KEY,
                event_name      VARCHAR(100) NOT NULL,
                event_date      TIMESTAMP NOT NULL,
                venue_id        INTEGER NOT NULL,
                age_restriction INTEGER CHECK (age_restriction >= 0),
                artist_id       INTEGER NOT NULL,
                CONSTRAINT fk_events_venue
                    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
                CONSTRAINT fk_events_artist
                    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Customers (
                customer_id      SERIAL PRIMARY KEY,
                first_name       VARCHAR(20) NOT NULL,
                last_name        VARCHAR(20) NOT NULL,
                email            VARCHAR(50) UNIQUE NOT NULL CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
                phone            VARCHAR(20) UNIQUE NOT NULL CHECK (phone ~ '^\+[0-9]{7,15}$'),
                registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Tickets (
                ticket_id           SERIAL PRIMARY KEY,
                event_id            INTEGER NOT NULL,
                customer_id         INTEGER,
                purchase_date       TIMESTAMP,
                price               INTEGER NOT NULL CHECK (price >= 0),
                previous_price      INTEGER,
                ticket_type         VARCHAR(50),
                seat_number         INTEGER CHECK (seat_number >= 0),
                CONSTRAINT fk_tickets_event
                    FOREIGN KEY (event_id) REFERENCES Events(event_id),
                CONSTRAINT fk_tickets_customer
                    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
            );
        """)

        conn.commit()

    except Exception as e:
        conn.rollback()
        print("Ошибка:", e)

    finally:
        cur.close()
        conn.close()


create_tables()
