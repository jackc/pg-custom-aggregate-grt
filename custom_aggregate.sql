drop aggregate if exists greatest_running_total(integer);
drop function if exists grt_finalfunc(integer[]);
drop function if exists grt_sfunc(integer[], integer);

create function grt_sfunc(accum integer[], el integer)
returns integer[]
immutable
language plpgsql
as $$
begin
  accum[2] = accum[2] + el;
  if accum[1] < accum[2] then
    accum[1] = accum[2];
  end if;

  return accum;
end;
$$;

-- create function grt_sfunc(accum integer[], el integer)
-- returns integer[]
-- immutable
-- language sql
-- as $$
-- select array[greatest(accum[1], accum[2]+el), accum[2]+el]::integer[];
-- $$;

create function grt_finalfunc(accum integer[])
returns integer
immutable
language plpgsql
as $$
begin
  return accum[1];
end;
$$;

create aggregate greatest_running_total (integer)
(
    sfunc = grt_sfunc,
    stype = integer[],
    finalfunc = grt_finalfunc,
    initcond = '{0,0}'
);
