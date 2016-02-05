# Custom Aggregate Greatest Running Total

This is the source code for the [Custom Aggregates in PostgreSQL](https://hashrocket.com/blog/posts/custom-aggregates-in-postgresql) blog post.

To load the test data:

```
psql -f structure.sql
```

To install the PL/pgSQL custom aggregate:

```
psql -f custom_aggregate.sql
```

To install the C custom aggregate:

```
make install
psql -f grt.sql
```

## License

MIT
