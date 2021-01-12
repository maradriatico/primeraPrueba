#!/bin/sh

if [ "$1" = "travis" ]; then
    psql -U postgres -c "CREATE DATABASE pruebecita_test;"
    psql -U postgres -c "CREATE USER pruebecita PASSWORD 'pruebecita' SUPERUSER;"
else
    sudo -u postgres dropdb --if-exists pruebecita
    sudo -u postgres dropdb --if-exists pruebecita_test
    sudo -u postgres dropuser --if-exists pruebecita
    sudo -u postgres psql -c "CREATE USER pruebecita PASSWORD 'pruebecita' SUPERUSER;"
    sudo -u postgres createdb -O pruebecita pruebecita
    sudo -u postgres psql -d pruebecita -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    sudo -u postgres createdb -O pruebecita pruebecita_test
    sudo -u postgres psql -d pruebecita_test -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    LINE="localhost:5432:*:pruebecita:pruebecita"
    FILE=~/.pgpass
    if [ ! -f $FILE ]; then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE; then
        echo "$LINE" >> $FILE
    fi
fi
