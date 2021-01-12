#!/bin/sh

BASE_DIR=$(dirname "$(readlink -f "$0")")
if [ "$1" != "test" ]; then
    psql -h localhost -U pruebecita -d pruebecita < $BASE_DIR/pruebecita.sql
fi
psql -h localhost -U pruebecita -d pruebecita_test < $BASE_DIR/pruebecita.sql
