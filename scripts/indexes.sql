CREATE INDEX IF NOT EXISTS idx_tickets_event_id
  ON tickets(event_id);

CREATE INDEX IF NOT EXISTS idx_events_event_date
  ON events(event_date);

CREATE INDEX IF NOT EXISTS idx_tickets_event_customer_sold
  ON tickets(event_id, customer_id)
  WHERE customer_id IS NOT NULL;