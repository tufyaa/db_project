-- 1) Сохранение старой цены (SCD Type 3)
-- Перед обновлением цены копируем OLD.price в NEW.previous_price
CREATE OR REPLACE FUNCTION trg_fn_tickets_scd3()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.price IS DISTINCT FROM OLD.price THEN
    NEW.previous_price := OLD.price;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_tickets_scd3
  BEFORE UPDATE ON tickets
  FOR EACH ROW
  EXECUTE FUNCTION trg_fn_tickets_scd3();


-- 2) Автоназначение места
-- При вставке, если seat_number не указан, находим первое свободное место до capacity
CREATE OR REPLACE FUNCTION trg_fn_assign_seat()
RETURNS TRIGGER AS $$
DECLARE
  v_capacity   INT;
  v_seat       INT;
BEGIN
  IF NEW.seat_number IS NULL THEN
    SELECT capacity INTO v_capacity
      FROM proj.venues v
      JOIN proj.events  e ON v.venue_id = e.venue_id
     WHERE e.event_id = NEW.event_id;

    SELECT seat
    INTO NEW.seat_number
    FROM generate_series(1, v_capacity) AS seat
    WHERE seat NOT IN (
        SELECT seat_number
        FROM proj.tickets
        WHERE event_id = NEW.event_id
    )
    LIMIT 1;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_assign_seat
  BEFORE INSERT ON tickets
  FOR EACH ROW
  EXECUTE FUNCTION trg_fn_assign_seat();


-- 3) Проверка даты покупки
CREATE OR REPLACE FUNCTION trg_fn_validate_purchase_date()
RETURNS TRIGGER AS $$
DECLARE
  v_event_date TIMESTAMP;
  v_reg_date   TIMESTAMP;
BEGIN
  IF NEW.purchase_date IS NOT NULL THEN
    SELECT event_date INTO v_event_date
      FROM events
     WHERE event_id = NEW.event_id;

    SELECT registration_date INTO v_reg_date
      FROM customers
     WHERE customer_id = NEW.customer_id;

    IF NEW.purchase_date >= v_event_date THEN
      RAISE EXCEPTION 'purchase_date (%) must be before event_date (%)', NEW.purchase_date, v_event_date;
    ELSIF NEW.purchase_date <= v_reg_date THEN
      RAISE EXCEPTION 'purchase_date (%) must be after customer registration (%)', NEW.purchase_date, v_reg_date;
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validate_purchase_date
  BEFORE INSERT OR UPDATE ON tickets
  FOR EACH ROW
  EXECUTE FUNCTION trg_fn_validate_purchase_date();