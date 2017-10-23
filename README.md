<small>
This was used as an external markdown source for reveal.js slide deck.
Forgive the sometimes weird reading flow that results.
</small>

# Intro to:<br>ERD and SQL

---

## ERD? SQL?

Today we learn some new *TLAs*!

- **ERD**: Entity Relationship Diagram
- **SQL**: Structured Query Language. Or just "Sequel".
- **TLA**: Three-Letter Acronym. (Get used to them.)

<small>
(And also why and how to use what they stand for. At least the first two.)
</small>

---

## Covered today:

### First half:

* Learn about ERD (what, why, how)
* Come up with an awesome app idea and we'll make an ERD for it.
    * By awesome I mean trivial.
    * Hopefully you give me ideas, or else it'll probably be pretty cliché.
* Write some SQL to create tables (in PostgreSQL) based on our ERD.

vvv

### After the break:

* Write more SQL to:
    * Insert data into our tables.
    * Query the data, explore different JOINs
    * Basic aggregations (maybe)

---

## Entity Relationship Diagrams

ERD is a diagramming method used to describe:

- Entities
- Attributes
- Keys
- Relationships
- Cardinality

---

### Entities

- Entities are *types of structured data* used by an app
- An *instance* of an Entity is an individual record
    - We might have an Entity "Tweet"
    - and many instances or records (tweets)
- An Entity describes the format (or schema) that its records must adhere to.

vvv

### Entities (cont'd)

Examples: Users, Products, Categories, Comments, Orders ...

- In SQL lingo: Entities correspond to Tables.
- In JS: Entities have so far been informal; we've just regularly
used plain objects that had the same kinds of properties as records.

---

### Attributes

- An entity has Attributes, which describe and constrain
  the property values of its records:
    - data type
    - value constraints (uniqueness, etc)
    - default values

```
Product
- id : integer (primary key, unique, not null)
- name : string (not null)
- price : numeric (not null, default 0.00)
```

- Comparison of ERD to SQL:
    - Entities have Attributes
    - Tables have Columns

---

### Keys

- A key is an attribute (or set of attributes) we can use to uniquely identify
  any single record in a table.

- In other words, if we got rid of every other attribute other than
  the key attribute(s), every record would still be unique.

- By querying using a key, we can fetch individual records.

vvv

### Keys

- A *simple key* consists of a single attribute
- A *compound key* consists of more than one: taken together, they're unique
  within the table.

```
warehouse_id | shelf_id | item
-------------+----------+----------------------------
 1           | 4        | a rubber duck
 1           | 6        | a decorative pineapple
 2           | 4        | a USB cable with cats on it
```

In this example, `warehouse_id` and `shelf_id` together work as a
compound key, even though neither are simple keys on their own.

vvv

### Keys

An entity can have any number of keys.

- A *primary key* is distinguished as the default key to use when
  querying for a record.
- A *foreign key* is not actually a key in the Entity it belongs to;
  it means a key from another table is making an appearance in this one.
    - This is how relationships are formed between records.

vvv

### Keys

A key can also be natural or artificial (or "surrogate"):

- A *natural key* is data that would "naturally" be part of the Entity
  anyway, but happens to qualify as a key.
    - Examples: Email, username, SIN...
- A *surrogate key* is added just for the sake of being a key.
  It has no "real world" meaning.
    - Example: an auto-incrementing integer `id` attribute

<small>
In practice, surrogate keys (especially integer keys named `id`) are
often added to all Entities even if they have a natural key, for
consistency. (Though it's a topic of debate.)
</small>

---

### Relationships

Relationships between Entities are created by adding *foreign key*
attributes.

This is in stark contrast to the "nested objects" seen in JS, JSON
and BSON (MongoDB).

Instead of nesting, a foriegn key can be used to look up the exact
record we want to reference. SQL JOINs make this even more powerful.

---

### Cardinality

When there's a relationship between entities, cardinality describes
"how many on either end" of the relationship.

- One-to-many
- One-to-one
- Many-to-many
- Mandatory or optional? (Min 0 or 1?)

vvv

### Cardinality

- One-to-many
    - Often phrased as "X has many Y"; thus "Y belongs to X"
    - Similar to a JS object property having an array as its value,
      but the array holds IDs, not the actual objects:

      ```
      user = {
        name: "Guy with pets",
        // pets: [ { ... }, { ... }, ... ], // No!
        pets: [ 3, 6, 9 ],
      }
      ```

vvv

### Cardinality

- One-to-one
    - Similar, except uniqueness is guaranteed on both sides.
    - An example would be a User having one Profile.

vvv

### Cardinality

- Many-to-many
    - "X has and belongs to many Y"
    - "Posts have many tags; Tags have many posts"
    - We actually need a third table (a "join table") to create
      the relationship: it holds two foreign keys.

---

## Let's make an ERD.

ERD is a methodology, not a specific tool. We could whiteboard an ERD.
But let's use software: https://www.lucidchart.com

### An ERD for what?

You tell me?

(Here's what we came up with during lecture:)

<a href="https://cl.ly/2h3a1u2q1n3i" target="_blank"><img src="https://d26dzxoao6i3hh.cloudfront.net/items/1o2t0I1E3G11370W0D0H/erd.png" style="display: block;height: auto;width: 100%;"/></a>

---

## SQL

SQL is mainly two things:

- A Data Definition Language (DDL)
    - Directives used to create and modify tables, columns, constraints,
      indexing behaviour, etc.
- A powerful query language for inserting, updating, deleting, and selecting
  data within the tables.

vvv

## SQL

Now that we have an ERD, we can use SQL to define our schema in PostgreSQL.

After that we can try some queries, explore SQL JOINs, and maybe even
do some basic aggregation.
