require_relative 'twitter_parser'

tp = TwitterParser.new
tp.load_data
tp.parse_tweets
