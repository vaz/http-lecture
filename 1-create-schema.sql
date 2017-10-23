-- Flights app schema - Data Definition



DROP TABLE IF EXISTS "passengers";
DROP TABLE IF EXISTS "flights";
DROP TABLE IF EXISTS "aircrafts";
DROP TABLE IF EXISTS "carriers";
DROP TABLE IF EXISTS "airports";
DROP TABLE IF EXISTS "people";

CREATE TABLE "people" (
  "id" serial PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "date_of_birth" date,
  "passport_number" varchar(100)
);

CREATE TABLE "airports" (
  "id" serial PRIMARY KEY,
  "name" varchar(255),
  "code" char(3)
);

CREATE TABLE "carriers" (
  "id" serial PRIMARY KEY,
  "name" varchar(255)
);

CREATE TABLE "aircrafts" (
  "id" serial PRIMARY KEY,
  "carrier_id" int REFERENCES "carriers",
  "model" varchar(255),
  "capacity" int
);

CREATE TABLE "flights" (
  "id" serial PRIMARY KEY,
  "aircraft_id" int REFERENCES "aircrafts",
  "carrier_id" int REFERENCES "carriers",
  "origin_id" int REFERENCES "airports",
  "destination_id" int REFERENCES "airports",
  "flight_number" varchar(255),
  "departure_time" timestamptz,
  "arrival_time" timestamptz
);

CREATE TABLE "passengers" (
  /* We don't need a surrogate id key here */
  /* "id" serial PRIMARY KEY, */
  "flight_id" int REFERENCES "flights",
  "person_id" int REFERENCES "people",
  "seat_number" varchar(100),

  /* Here's a compound key: */
  PRIMARY KEY ("flight_id", "person_id")
);

