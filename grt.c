#include "postgres.h"
#include "fmgr.h"
#include "utils/geo_decls.h"

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(grt_sfunc);

Datum
grt_sfunc(PG_FUNCTION_ARGS)
{
	Point *new_agg_state = (Point *) palloc(sizeof(Point));
	double el = PG_GETARG_FLOAT8(1);

	bool isnull = PG_ARGISNULL(0);
	if(isnull) {
		new_agg_state->x = el;
		new_agg_state->y = el;
		PG_RETURN_POINT_P(new_agg_state);
	}

	Point *agg_state = PG_GETARG_POINT_P(0);

	new_agg_state->x = agg_state->x + el;
	if(new_agg_state->x > agg_state->y) {
		new_agg_state->y = new_agg_state->x;
	} else {
		new_agg_state->y = agg_state->y;
	}

	PG_RETURN_POINT_P(new_agg_state);
}
