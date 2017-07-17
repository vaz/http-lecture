
# Intro to ERD and SQL

In this lecture we're reviewing ERD and putting one together for a simple app concept.
Then writing the SQL to create corresponding tables, insert data and query it. In the
process we explore the different types of table join, and touch on aggregation.


## ERD

ERD is very useful! Data modeling is super important, it's the foundation of an application.
Your data design will strongly influence how the rest of the app comes together.

ERD is lightweight (as far as diagramming methods go) and perfect for modeling relational database
schemas. You can whiteboard it or use one of many tools (I used [LucidChart](https://www.lucidchart.com/)
during the lecture, there are many others out there).

Parts of ERD in point-form:

  - Entities
    - An entity (or record type, or table) has instances (or records, or rows)
    - These are the types of things (data) that we care about in our app.
    - Or, our "business domain objects" if you wanna sound like an engineer.
  - Attributes
    - AKA properties, fields, columns, belonging to our entities.
  - Keys
    - A *primary key* uniquely identifies every instance (row)
    - A *foreign key* is a primary key making an appearance in another table.
      It doesn't act like a key in that table (it's not always unique, or else
      every relationship would be one-to-one).
    - *Natural* vs *surrogate* (or artificial) keys: a natural key is part of
      the data already (like a SIN or email), while a surrogate key is added
      just to use as a key (like an auto-incrementing integer ID).
    - *Simple keys* are made up of a single attribute. *Compound keys* are
      made up of multiple attributes that are *unique together* within the table.
  - Relationships
    - Connections between entities.
    - Often described with phrases like "has a", "belongs to", "has many".
    - Described in "normal form" using foreign key relationships to avoid
      data duplication.
  - Cardinality
    - One-to-one, one-to-many, many-to-many
    - Mandatory versus optional (minimum of 0, or 1?)


## SQL

### Creating tables

See `schema.sql`.

Notes:

- I used `DROP TABLE IF EXISTS...` before my `CREATE TABLE` statements
  so that I could run and re-run the file while making changes. I dropped
  tables in reverse order to how they're created, to respect foreign key
  constraints. The `IF EXISTS` prevents an error if the table is not
  there to be dropped (which is the case when this file is first executed).

#### Data types and modifiers

- `serial`: really a shorthand for "non-nullable, auto-incrementing integer"
- Make `varchar` as big as it needs to be. Or 255 chars if you're not
  concerned about optimizing (at this point, you're not).
  Longer texts should use type `text`.
- The `numeric` data type is best for storing money. Floating point arithmetic is
  prone to rounding errors.  Integer (as cents) can work for currency but you
  have to convert it back and forth.

Constraints, defaults:

- `NOT NULL`: adds `NOT NULL` constraint; will not save a row with a `NULL` in this field
  - In typical DB design, fields are *not nullable* more often than they
    are *nullable* (but `NULL` is the default, you have to specify `NOT NULL` if you want it).
- `DEFAULT <value>`: default value assigned if no value is specified during insert
- `REFERENCES table (column)`: add foriegn key constraint linking this field to the referenced
  field in other table.
- `REFERENCES table`: same as above, but use `table`'s PK as the column by default
- `PRIMARY KEY`: adds uniqueness and `NOT NULL` constraints on this field; this key is used
  as FK in other tables; the table is indexed on this key for faster queries

### Inserting data

See `insert.sql`.

Similar to when creating schema, I used `DELETE FROM table` naming tables in reverse order from
how I insert data to make the file re-runnable. If you list out column names in an INSERT, you
can re-order them or omit some of them (like auto-generated IDs or timestamps).

### SELECT with JOIN

See `selects.sql`.

Did some basic SELECTs and JOINs. Discussed `INNER JOIN`, `LEFT/RIGHT/FULL OUTER JOIN`: taking
left/right by which table(s) you name on each side of the JOIN keyword, the outer joins will
ensure every row from the left/right/both appears in the result, even if it has no matching row
for this join condition.

Also looked at many-to-many, querying for cart items in a format like you'd see on a cart page
(with product name, unit price, quantity, line total). Requires 2 joins (3 tables) to do, and
displays some data from each table. Example output:

```sql
 cart_id |  product_name  | unit_price | quantity | line_total
---------+----------------+------------+----------+------------
       1 | Cetaphil       |      10.99 |        3 |      32.97
       1 | Rubber Chicken |       5.00 |        1 |       5.00
       3 | Poke Ball      |     200.00 |       10 |    2000.00
(3 rows)
```

### Basic aggregation

Finally, we look at a cart summary query using SUM to aggregate prices (actually the calculated
line totals from the previous query), and `GROUP BY carts.id` to get a total (sum) price for
*each cart*. Example output:

```sql
 cart_id |          cart_details          | cart_total
---------+--------------------------------+------------
       1 | Cetaphil x3, Rubber Chicken x1 |      37.97
       3 | Poke Ball x10                  |    2000.00
(2 rows)
```

Another way to look at it: look at query output before the aggregate/GROUP BY are added and think
about "collapsing" or "squashing" rows with some matching value (the GROUP BY value, like cart ID).
For any other fields, think of how they aggregate (collapse together, like summing or averaging
or joining as strings with `STRING_AGG`, which I added to generate `cart_details` just for fun)
and if they even should, otherwise they need to be removed from the SELECT.
