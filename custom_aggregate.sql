drop aggregate if exists greatest_running_total(float8);
drop function if exists grt_finalfunc(point);
drop function if exists grt_sfunc(point, float8);

create function grt_sfunc(agg_state point, el float8)
returns point
immutable
language plpgsql
as $$
declare
  greatest_sum float8;
  current_sum float8;
begin
  if agg_state is null then
    return point(el, el);
  end if;

  current_sum := agg_state[0] + el;
  if agg_state[1] < current_sum then
    greatest_sum := current_sum;
  else
    greatest_sum := agg_state[1];
  end if;

  return point(current_sum, greatest_sum);
end;
$$;

create function grt_finalfunc(agg_state point)
returns float8
immutable
strict
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
