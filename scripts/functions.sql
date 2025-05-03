-- Функция 1: get_event_revenue
-- Возвращает общую выручку по заданному event_id
CREATE OR REPLACE FUNCTION get_event_revenue(
    p_event_id INT
) RETURNS NUMERIC
LANGUAGE sql AS
$$
  SELECT COALESCE(SUM(price), 0)
    FROM tickets
   WHERE event_id = p_event_id
     AND customer_id IS NOT NULL;
$$;


-- Функция 2: get_customer_total_spent
--   Возвращает сумму всех затрат клиента по его покупкам билетов
CREATE OR REPLACE FUNCTION get_customer_total_spent(
    p_customer_id INT
) RETURNS NUMERIC
LANGUAGE sql AS
$$
  SELECT COALESCE(SUM(price), 0)
    FROM tickets
   WHERE customer_id = p_customer_id;
$$;