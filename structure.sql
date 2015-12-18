drop table if exists entries;
create table entries(
  id serial primary key,
  amount integer not null
);

insert into entries(amount)
select (2000 * random())::integer - 1000
from generate_series(1, 100000);
