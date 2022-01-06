\set QUIET 1
\pset pager off
\pset footer off
\timing off
CREATE TEMP TABLE temp_tweets (LIKE twitter.favorite_tweets INCLUDING ALL);

\COPY temp_tweets from '/favorite_tweets.csv' delimiter ',' header csv;

\set QUIET 0
INSERT INTO twitter.favorite_tweets (id, created_at, "user", name, text)
SELECT t2.* FROM temp_tweets t2
LEFT JOIN twitter.favorite_tweets t1 ON
t1.id = t2.id
WHERE
t1.created_at is NULL
ON CONFLICT DO NOTHING
RETURNING *;
