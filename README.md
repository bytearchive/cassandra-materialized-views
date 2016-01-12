# Materialized Views In Cassandra

## Prerequisites

* Docker (I am using docker-machine 0.5.5 on Mac OS X).

Docker handles the rest.

## Start the Cassandra Container

You can either build the docker images yourself (`docker build -t gdusbabek/cassandra-views .`), or you can pull from
Dockerhub (`docker pull gdusbabek/cassandra-views`).

Then start the image:

    docker run --name cass-test1 -it gdusbabek/cassandra-views

You should be inside of a [cqlsh](https://docs.datastax.com/en/cql/3.3/cql/cql_reference/cqlsh.html) shell.

## CQL

All the queries you need are in four files:

* `01_create_schema.cql` creates the schema including the materialized views.
* `02_load_data.cql` will load all the album data.
* `03_queries.cql` contains the queries used in the screencast.

## Links

* [Docker image](https://hub.docker.com/r/gdusbabek/cassandra-views/tags/)
* [Github project](https://github.com/silicon-valley-data-science/cassandra-materialized-views)