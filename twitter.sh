#!/bin/sh

DB_HOST="${PGHOST:-localhost}"
DB_PORT="${PGPORT:-5432}"
DB_NAME="${PGDATABASE:-postgres}"
DB_USER="${PGUSER:-postgres}"

/python-fav-tweets.py
psql -d "${DB_NAME}" -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" --file=/postgres-fav-tweets.sql
#vacuumdb -q -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" --jobs=2 --analyze -w --table='twitter.favorite_tweets' "${DB_NAME}"
