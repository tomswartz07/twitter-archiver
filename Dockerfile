FROM python:3.10.2-alpine
LABEL org.opencontainers.image.source=https://github.com/tomswartz07/twitter-archiver
LABEL org.opencontainers.image.authors="tom+docker@tswartz.net"
LABEL description="Docker container to run a Twitter scrape tool to save/archive account's favorited tweets."

ENV PGHOST="localhost"
ENV PGPORT="5432"
ENV PGDATABASE="postgres"
ENV PGUSER="postgres"
ENV PGPASSWORD="postgres"
ENV CONSUMER_KEY=""
ENV CONSUMER_SECRET=""
ENV ACCESS_KEY=""
ENV ACCESS_SECRET=""
ENV TWITTER_USERNAME=""

COPY twitter.sh .
COPY postgres-fav-tweets.sql .
COPY python-fav-tweets.py .
COPY requirements.txt .
COPY crontab .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

RUN apk update && apk add --no-cache postgresql-client
RUN crontab crontab

CMD [ "crond", "-f" ]
