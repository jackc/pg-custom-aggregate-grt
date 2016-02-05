drop table if exists entries;
create table entries(
  id serial primary key,
  amount float8 not null
);

-- Ensure "random" rows are created the same for each test run.
select setseed(0);

insert into entries(amount)
select (2000 * random()) - 1000
from generate_series(1, 1000000);
