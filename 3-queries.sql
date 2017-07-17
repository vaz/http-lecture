-- SELECT examples with joins and aggregation


-- Simple SELECT all columns
--
-- SELECT * FROM users;
-- SELECT * from carts;


-- SELECT all columns from users joined with carts
-- The result looks kind of like the previous two stuck side by side.
-- Rows are matched up based on the ON clause.
--
-- SELECT *
-- FROM users
--   JOIN carts ON users.id = carts.user_id;


-- Clean up output of the previous by selecting specific fields, in a nice order,
-- and giving the fields aliases with AS.
-- Also call it INNER JOIN, which is the same as just JOIN (it's the default).
--
-- SELECT users.email AS user_email, carts.id AS cart_id, carts.created_at AS cart_created_at
-- FROM users
--   INNER JOIN carts ON users.id = carts.user_id;


-- Same as last time, but try LEFT OUTER JOIN.
-- LEFT OUTER JOIN on "users joined with carts" means, give me ALL users, and
-- their associated cart info if they have it (those columns will be null,
-- otherwise).
-- (In contrast, INNER JOIN drops any rows with a user but no cart.)
--
-- SELECT users.email AS user_email, carts.id AS cart_id, carts.created_at AS cart_created_at
-- FROM users
--   LEFT OUTER JOIN carts ON users.id = carts.user_id;


-- Many-to-many:

-- Get each cart item, with its product name and product (unit) price,
-- quantity, and calculated line total (quantity * unit price)
-- It's especially nice to give aliases (with AS) to calculated values.
--
-- The result has one row per cart item (so it can have multiple rows per cart).
--
SELECT
  carts.id AS cart_id,
  products.name AS product_name,
  products.price AS unit_price,
  cart_items.quantity AS quantity,
  (products.price * cart_items.quantity) AS line_total
FROM cart_items
  INNER JOIN products ON products.id = cart_items.product_id
  INNER JOIN carts ON carts.id = cart_items.cart_id;

-- Get a summary for each cart, one row per cart, including the cart total
-- (sum of all line totals of its cart items).
--
-- Here we're using an aggregate function, SUM(), along with GROUP BY on the
-- cart id. So any rows with matching cart_id (see previous query which
-- does a similar join) are collapsed together. Any fields in the SELECT
-- other than the one(s) we GROUP BY must be aggregated. Otherwise it doesn't
-- know how to collapse them into a single record!
--
-- The cart_details is an embellishment I added after the fact. It's another
-- aggregate function for combining strings (product names in this case).
-- As long as it's an aggregate, it can be included in the SELECT.
--
SELECT
  carts.id AS cart_id,
  STRING_AGG(CONCAT(products.name, ' x', cart_items.quantity), ', ') AS cart_details,
  SUM(products.price * cart_items.quantity) AS cart_total
FROM cart_items
  INNER JOIN products ON products.id = cart_items.product_id
  INNER JOIN carts ON carts.id = cart_items.cart_id
GROUP BY carts.id;
