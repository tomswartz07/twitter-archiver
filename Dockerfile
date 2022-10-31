FROM python:3.11-alpine
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

RUN apk update && apk add --no-cache postgresql-client
COPY crontab .
RUN crontab crontab
COPY postgres-fav-tweets.sql .
COPY twitter.sh .
COPY requirements.txt .
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
COPY python-fav-tweets.py .

CMD [ "crond", "-f" ]
