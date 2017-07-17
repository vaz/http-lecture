-- Products and Carts Schema - Data Definition

DROP TABLE IF EXISTS "cart_items";
DROP TABLE IF EXISTS "carts";
DROP TABLE IF EXISTS "users";
DROP TABLE IF EXISTS "products";

CREATE TABLE "products" (
  "id" serial PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "manufacturer" varchar(255),
  "price" numeric NOT NULL DEFAULT '0.00',
  "inventory" int NOT NULL DEFAULT '0',
  "description" text
);

CREATE TABLE "users" (
  "id" serial PRIMARY KEY,
  "email" varchar(255) NOT NULL,
  "joined_at" timestamp DEFAULT CURRENT_TIMESTAMP -- does what it sounds like
);

CREATE TABLE "carts" (
  "id" serial PRIMARY KEY,
  "user_id" integer REFERENCES "users", -- is nullable (cardinality: 0 or 1)
  "created_at" timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "cart_items" (
  "cart_id" integer REFERENCES "carts" NOT NULL,
  "product_id" integer REFERENCES "products" NOT NULL,
  "quantity" integer NOT NULL
);
