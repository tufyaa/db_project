-- Индекс 1: ускоряет выборку билетов по event_id
-- Часто используется при фильтрации билетов для конкретного события,
-- например, при подсчёте продаж.
CREATE INDEX IF NOT EXISTS idx_tickets_event_id
  ON tickets(event_id);

-- Индекс 2: ускоряет выборку событий по дате (event_date)
-- Особенно полезен для запросов, где нужно найти грядущие события (event_date > NOW()),
-- как в представлении upcoming_events.
CREATE INDEX IF NOT EXISTS idx_events_event_date
  ON events(event_date);

-- Индекс 3: комбинированный индекс по (event_id, customer_id) только для проданных билетов
-- Используется в аналитике и отчётах, где часто выбираются только проданные билеты
-- по конкретному событию и конкретному клиенту (например, для анализа поведения покупателей).
-- Частичный индекс уменьшает размер и ускоряет выборки по условию customer_id IS NOT NULL.

CREATE INDEX IF NOT EXISTS idx_tickets_event_customer_sold
  ON tickets(event_id, customer_id)
  WHERE customer_id IS NOT NULL;