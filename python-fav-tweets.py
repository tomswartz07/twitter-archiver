#!/usr/bin/env python
"Download all user tweets into csv"
# encoding: utf-8

import os
import csv
import tweepy #https://github.com/tweepy/tweepy

# Twitter User to scrape favorites
twitter_username = os.environ.get('TWITTER_USERNAME')

#Twitter API credentials
consumer_key = os.environ.get('CONSUMER_KEY')
consumer_secret = os.environ.get('CONSUMER_SECRET')
access_key = os.environ.get('ACCESS_KEY')
access_secret = os.environ.get('ACCESS_SECRET')

def get_all_tweets(screen_name):
    "Twitter only allows access to a users most recent 3240 tweets with this method"

    #authorize twitter, initialize tweepy
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_key, access_secret)
    api = tweepy.API(auth,wait_on_rate_limit=True)

    #initialize a list to hold all the tweepy Tweets
    alltweets = []

    #make initial request for most recent tweets (200 is the maximum allowed count)
    new_tweets = api.get_favorites(screen_name=screen_name, count=200)

    #save most recent tweets
    alltweets.extend(new_tweets)

    #save the id of the oldest tweet less one
    oldest = alltweets[-1].id - 1

    #keep grabbing tweets until there are no tweets left to grab
    while len(new_tweets) > 0:
        #print("getting tweets before %s" % (oldest))

        #all subsiquent requests use the max_id param to prevent duplicates
        new_tweets = api.get_favorites(screen_name=screen_name, count=200, max_id=oldest)

        #save most recent tweets
        alltweets.extend(new_tweets)

        #update the id of the oldest tweet less one
        oldest = alltweets[-1].id - 1

    #transform the tweepy tweets into a 2D array that will populate the csv
    outtweets = [[tweet.id_str, tweet.created_at, tweet.user.screen_name, tweet.user.name,
                  tweet.text] for tweet in alltweets]

    #write the csv
    with open('/favorite_tweets.csv', 'w', encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["id", "created_at", "user", "name", "text"])
        writer.writerows(outtweets)

if __name__ == '__main__':
    get_all_tweets(twitter_username)
