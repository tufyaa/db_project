-- Процедура 1: purchase_ticket
-- Проверяет, что билет существует и не продан.
-- Обновляет previous_price = price.
-- Устанавливает новую цену.

CREATE OR REPLACE PROCEDURE purchase_ticket(p_ticket_id INT,p_new_price INT)
LANGUAGE plpgsql AS
$$
DECLARE
    v_current_price INT;
BEGIN
    SELECT price
      INTO v_current_price
      FROM tickets
     WHERE ticket_id = p_ticket_id
       AND customer_id IS NULL
    FOR UPDATE;

    UPDATE tickets
       SET previous_price = v_current_price,
           price = p_new_price,
           purchase_date = NOW()
     WHERE ticket_id = p_ticket_id;
END;
$$;
