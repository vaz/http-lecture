-- Query examples

-- Simple SELECT
/* SELECT * FROM people; */

-- Select specific columns, calculate stuff
-- Gives an alias to the calculated field (the AS keyword is optional)
/* SELECT name, extract(years from age(CURRENT_TIMESTAMP, date_of_birth)) AS age */
/*   FROM people; */

/* -- Filter by calculated result (broken) */
/* SELECT name, extract(years from age(current_timestamp, date_of_birth)) AS age */
/*   FROM people */
/*   WHERE age >= 25; -- Oops! Why doesn't it work? */

/* -- Filtering with WHERE actually happens way before the SELECT clause is */
/* -- used to narrow or compute results, so it can only use actual column names. */
/* -- So... how? */

-- Filter by calculated result (fixed, using sub-query)
/* SELECT * FROM */
/*   ( */
/*     SELECT name, extract(years from age(current_timestamp, date_of_birth)) AS age */
/*       FROM people */
/*   ) AS name_and_age */
/*   WHERE age >= 25; */

/* ---------------------------- */
/* -- Joins */

-- Aircraft and the carriers that own them:

-- INNER JOIN combines the tables but only returns the rows that match
-- the criteria. It's the default JOIN.
SELECT carriers.name AS "airline", aircrafts.model AS "owned_aircraft"
  FROM carriers INNER JOIN aircrafts
    ON carriers.id = aircrafts.carrier_id;

/* -- LEFT OUTER JOIN will make sure every row from the left table */
/* -- (the table named on the left side) is present in the output, */
/* -- even if the criteria doesn't match; the columns depending */
/* -- on the right side will just be null (empty). */
/* SELECT carriers.name AS "airline", aircrafts.model AS "owned_aircraft" */
/*   FROM carriers LEFT OUTER JOIN aircrafts */
/*     ON carriers.id = aircrafts.carrier_id; */

/* -- RIGHT OUTER JOIN is the same but for the table that you name */
/* -- on the right hand side: */
/* SELECT carriers.name AS "airline", aircrafts.model AS "owned_aircraft" */
/*   FROM carriers RIGHT OUTER JOIN aircrafts */
/*     ON carriers.id = aircrafts.carrier_id; */

/* -- FULL OUTER JOIN is like left and right combined. Show a row for */
/* -- every row of either table even if the other side is empty. */
/* SELECT carriers.name AS "airline", aircrafts.model AS "owned_aircraft" */
/*   FROM carriers FULL OUTER JOIN aircrafts */
/*     ON carriers.id = aircrafts.carrier_id; */

-- Many-to-Many
-- Aggregates (maybe)
