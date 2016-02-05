drop aggregate if exists greatest_running_total(float8);
drop function if exists grt_finalfunc(point);
drop function if exists grt_sfunc(point, float8);

create function
  grt_sfunc( point, float8 )
returns
  point
as
  'grt.so', 'grt_sfunc'
language
  c
immutable;

create function grt_finalfunc(agg_state point)
returns float8
immutable
language plpgsql
as $$
begin
  return agg_state[1];
end;
$$;

create aggregate greatest_running_total (float8)
(
    sfunc = grt_sfunc,
    stype = point,
    finalfunc = grt_finalfunc
);




