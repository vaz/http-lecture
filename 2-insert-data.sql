-- Insering data


-- So that I can run this script over and over...
-- Deleting all records from each table, one at a time, in reverse order
-- from how I insert them (to respect constraints like foreign key).
--
-- See how scary DELETE FROM table without a WHERE clause is. Imagine having
-- lots of important data.
DELETE FROM "cart_items";
DELETE FROM "carts";
DELETE FROM "users";
DELETE FROM "products";

INSERT INTO "products" (id, name, price, inventory, description) VALUES
  (1, 'Cetaphil',       '10.99',    23, 'I don''t know what this is'),
  (2, 'Rubber Chicken', '5.00',   1000, 'For debugging'),
  (3, 'Poke Ball',      '200.00',  100, 'Red and white');

INSERT INTO "users" (id, email) VALUES
  (1, 'vaz@example.com'),
  (2, 'joe@example.com'), -- a user with no carts
  (3, 'pikachu@example.com');

INSERT INTO "carts" (id, user_id, created_at) VALUES
  (1, 1, '2010-01-01 00:00'), -- my "old" cart
  (2, 1, DEFAULT), -- my current cart
  (3, 3, DEFAULT),
  (4, NULL, DEFAULT); -- a cart with no user

INSERT INTO "cart_items" (cart_id, product_id, quantity) VALUES
  (1, 1, 3), -- Cetaphil x3 in cart 1
  (1, 2, 1), -- Rubber Chicken x1 in cart 1
  (3, 3, 10); -- Poke Ball x10 in cart 3
