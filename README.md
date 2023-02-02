# Tweet Importer

**NOTE:**
Given recent changes to Twitter Ownership and an [upcoming change to the
API](https://twitter.com/TwitterDev/status/1621026986784337922), it is very
likely that this service will not function after 9 Feb 2023.


Import tweets into a PostgreSQL database for archival purposes.

Keeping the messages safe for review if the original tweets have been
deleted, removed, or if the account was made private.


# Using

First, you'll need a Twitter API key.

1. Log in and [get one](https://developer.twitter.com/en).

2. Define the relevant info as ENV vars for the docker container, including the API vars

3. Prepare the DB with the `schema.sql` file provided:
    ```
    psql -f schema.sql
    ```
4. Run the docker image.

The docker image will run the python script to get a CSV output,
then run the SQL to import the information in to the DB in 15 min intervals.
