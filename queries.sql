-- Initial running total
select id, amount, sum(amount) over (order by id asc) as running_total
from entries
;

-- What is greatest running total
select max(running_total)
from (
  select sum(amount) over (order by id asc) as running_total
  from entries
) t
;

-- What is greatest running total with custom aggregate
select greatest_running_total(amount order by id asc) from entries;

-- What and when was the greatest running total
select *
from (
  select id, amount, sum(amount) over (order by id asc) as running_total
  from entries
) t
order by running_total desc
limit 1
;

-- What and when is greatest running total
select id, amount, sum(amount) over w as running_total
from entries
window w as (order by id asc)
order by sum(amount) over w desc
limit 1
;
