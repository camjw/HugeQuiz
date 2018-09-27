require_relative 'twitter_parser'
require 'pg'

connection = PG.conn(dbname: 'quiz_questions')
connection.exec('TRUNCATE questions RESTART IDENTITY;')

tp = TwitterParser.new
tp.load_data
tp.parse_tweets
