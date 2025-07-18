-- create and populate the 'accounts' table
create or replace table demo.accounts (
  id int64,
  name string,
  employees int64
);
insert into demo.accounts (id, name, employees)
values
  (1, 'Acme', 80),
  (2, 'Initech', 120);

-- create and populate the 'products' table
create or replace table demo.products (
  id int64,
  name string,
  account_name string
);
insert into demo.products (id, name, account_name)
values
  (1, 'Rockets', 'Acme'),
  (2, 'Portable Holes', 'Acme'),
  (3, 'Synergy', 'Initech');

-- create and populate the 'managers' table
create or replace table demo.managers (
  id int64,
  name string,
  account_name string
);
insert into demo.managers (id, name, account_name)
values
  (1, 'Wakko', 'Acme'),
  (2, 'Yakko', 'Acme'),
  (3, 'Dot', 'Acme'),
  (4, 'Bill', 'Initech');


-- Create and populate the 'pageviews' table
-- This table is denormalized and contains event data for pageviews.
CREATE OR REPLACE TABLE demo.pageviews (
  event_date DATE,
  product STRING,
  user_id INT64
);

INSERT INTO demo.pageviews (event_date, product, user_id)
VALUES
  (DATE('2017-01-01'), 'Rockets', 1),
  (DATE('2017-01-01'), NULL, 2),
  (DATE('2017-03-15'), 'Portable Holes', 7423);


-- Create and populate the 'orders' table
-- This table is denormalized and contains transaction data.
CREATE OR REPLACE TABLE demo.orders (
  order_date DATE,
  product STRING,
  amount NUMERIC,
  user_id INT64
);

INSERT INTO demo.orders (order_date, product, amount, user_id)
VALUES
  (DATE('2017-01-01'), 'Rockets', 200, 37),
  (DATE('2017-01-02'), 'Synergy', 1000, 46),
  (DATE('2017-03-15'), 'Portable Holes', 50, 4910);

-- query to produce the fanned-out result
select
  a.id as account_id,
  a.name as account_name,
  a.employees,
  p.id as product_id,
  p.name as product_name,
  m.id as manager_id,
  m.name as manager_name
from
  demo.accounts as a
left join
  demo.products as p
  on a.name = p.account_name
left join
  demo.managers as m
  on a.name = m.account_name
order by
  account_id,
  product_id,
  manager_id;
