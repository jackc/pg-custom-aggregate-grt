MODULES = grt
PGXS := $(shell pg_config --pgxs)
include $(PGXS)
