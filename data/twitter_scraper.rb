require 'twitter'
require 'yaml'

# This class downloads all the tweets from HQTriviaScribe and parses them for
# entry into the questions database.
config = {
  consumer_key: ENV['TWITTER_KEY'],
  consumer_secret: ENV['TWITTER_SECRET']
}

client = Twitter::REST::Client.new(config)

def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield(max_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 200, include_rts: true}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end

quiz_source = 'HQTriviaScribe'

data = client.get_all_tweets(quiz_source)

File.write('tweet_text.yml', YAML.dump(data.map { |tweet| tweet.full_text }))
