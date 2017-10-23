-- Insert some example data

DELETE FROM "passengers";
DELETE FROM "flights";
DELETE FROM "aircrafts";
DELETE FROM "carriers";
DELETE FROM "airports";
DELETE FROM "people";

INSERT INTO "people"
  (id, name, date_of_birth, passport_number) VALUES
  (1, 'Person A', now() - interval '22 years',   '11111111'),
  (2, 'Person B', now() - interval '27.6 years', '22222222'),
  (3, 'Person who hates flying', '1976-04-03',   '33333333');

INSERT INTO "airports"
  (id, name, code) VALUES
  (1, 'Vancouver International', 'YVR'),
  (2, 'Los Angeles Airport', 'LAX');

INSERT INTO "carriers"
  (id, name) VALUES
  (1, 'Air Canada'),
  (2, 'Delta Airlines'),
  (3, 'Super discount airlines (defunct)');

INSERT INTO "aircrafts"
  (id, carrier_id, model, capacity) VALUES
  /* I don't know anything about planes. */
  (1, 1, 'Boeing 747', 150),
  (2, 1, 'Boeing 757', 200),
  (3, 2, 'Boeing 747', 150),
  (4, null, 'Fighter Jet', 3);
  -- No carrier owns the fighter jet
  -- carrier 3 (discount airlines) doesn't have any aircraft

INSERT INTO "flights"
  (id, flight_number, aircraft_id, carrier_id,
    departure_time, arrival_time, origin_id, destination_id)
  VALUES
  (1, '12345A', 1, 1,
    '2004-10-19 10:44:00-07',
    '2004-10-19 14:53:54-07',
    1, 2),
  (2, '12456B', 3, 2,
    now() - interval '100 days',
    now() - interval '100 days' + interval '4 hours',
    2, 1),
  (3, '12456B', 2, 1,
    now() - interval '70 days',
    now() - interval '70 days' + interval '4 hours',
    2, 1);

INSERT INTO "passengers" (flight_id, person_id, seat_number) VALUES
  (1, 1, '12A'),
  (1, 2, '14B'),
  (2, 1, '13C'),
  (2, 2, '13B'),
  (3, 1, '8A');


/* INSERT INTO "..." (id, ...) VALUES */
/*   (...), */
/*   (...); */
