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
                artist_id    SERIAL PRIMARY KEY,
                name         VARCHAR(100) NOT NULL,
                main_genre   VARCHAR(100),
                phone_number VARCHAR(20) NOT NULL,
                email        VARCHAR(100) NOT NULL
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Venues (
                venue_id   SERIAL PRIMARY KEY,
                venue_name VARCHAR(100) NOT NULL,
                address    VARCHAR(100) NOT NULL,
                capacity   INTEGER,
                email      VARCHAR(100) NOT NULL
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Events (
                event_id        SERIAL PRIMARY KEY,
                event_name      VARCHAR(100) NOT NULL,
                event_date      TIMESTAMP NOT NULL,
                venue_id        INTEGER NOT NULL,
                age_restriction INTEGER,
                artist_id       INTEGER NOT NULL,
                CONSTRAINT fk_events_venue
                    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
                CONSTRAINT fk_events_artist
                    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Customers (
                customer_id       SERIAL PRIMARY KEY,
                first_name        VARCHAR(100) NOT NULL,
                last_name         VARCHAR(100) NOT NULL,
                email             VARCHAR(100) UNIQUE NOT NULL,
                phone             VARCHAR(20) UNIQUE NOT NULL,
                registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS Tickets (
                ticket_id      SERIAL PRIMARY KEY,
                event_id       INTEGER NOT NULL,
                customer_id    INTEGER,
                purchase_date  TIMESTAMP,
                price          INTEGER NOT NULL,
                previous_price INTEGER,
                ticket_type    VARCHAR(100),
                seat_number    INTEGER,
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
