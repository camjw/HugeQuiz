# Quizlet

This repository is a multiple choice quiz game created in Ruby. Players answer as many questions as they can without running out of lives, and then can see their score in a leaderboard if they scored highly enough.
## Getting Started

This app is a Ruby app, so the user must have Ruby installed as well as Bundler, to download the correct gems.

### Prerequisites

There are only moderate prerequisites to running this app locally: Sinatra, PostgreSQL and a Twitter developer account if the user wants to update the database.

#### SQL databases
Running this repository locally requires PostgreSQL to manage the leaderboard
and question tables. A database called `quiz_questions` should be created with
the following tables:

```sql
questions(id SERIAL PRIMARY KEY, question(VARCHAR(1000)), first_answer(VARCHAR(100)),
 second_answer(VARCHAR(100)), third_answer(VARCHAR(100)), correct_answer(INTEGER))
```

```sql
leaderboard(id SERIAL PRIMARY KEY, name(VARCHAR(100)), first_answer(VARCHAR(1000)), score(INTEGER))
```

PostgreSQL can be downloaded from [here](https://www.postgresql.org/download/).

#### Updating the `questions` database

The database of questions has been populated by scraping a twitter feed found [here](https://twitter.com/HQTriviaScribe). This feed posts daily the multiple choice questions used in the HQ Trivia app quiz. This app can be downloaded for iOS [here](https://itunes.apple.com/gb/app/hq-live-trivia-game-show/id1232278996?mt=8), and offers cash prizes which this app unfortunately does not.

Updating the database of questions requires rescraping the Twitter feed, which requires a Twitter developer account. If you already have one, store your developer key and secret locally as environment variables with names `TWITTER_KEY` and `TWITTER_SECRET` and run `data/twitter_scraper.rb` to update the `tweet_text.yml` file.

### Installing

Assuming you have created the PostgreSQL databases described above, clone this repository and run `bundle install` to install the necessary gems.

To populate the questions database run `ruby data/tweet_parsing_script.rb` from the root of the directory. This script uses the `TwitterParser` class to convert the `YAML` representations of the tweets to an entry which looks like: `[question, first_answer, second_answer, third_answer, correct_answer]`. The following method then runs:

```ruby
def store_into_database(entry)
  @connection.exec('INSERT INTO questions(question, first_answer, '\
    "second_answer, third_answer, correct_answer) VALUES('#{entry[0]}', "\
    "'#{entry[1]}', '#{entry[2]}', '#{entry[3]}', #{entry[4]});")
end
```

The last thing to do is `rackup` the app to whichever localhost you like, and play the game!

## Running the tests

To run the tests run `rspec` from the root of the directory. There are 20 tests which cover the entirety of the library code.

As with the app itself, two databases are required to run the tests. Create a new database `quiz_questions_test` with the same tables as the `qui_questions` database to run the tests.

### Example

One of our feature tests is checking that the correct answer moves the user on to the next question. We randomly select the questions from a database of over 2500 questions, so testing that the selecting the correct answer moves the player on to the next question is slightly involved. Fortunately our test database only has three questions so this isn't too tricky.

This is the function which selects the correct answer for us:

```ruby
def get_correct_answer(page)
  answers = %w[Four Sharks Hairspray]
  answers.each do |answer|
    return answer if page.has_selector?("input[type='submit']"\
      "[value='#{answer}']")
  end
end
```
Note that there are four holes in a polo. Running the test is then quite simple:
```ruby
feature 'The user progresses' do
  scenario 'when they answer correctly' do
    initialize_test_questions_table
    attempt_first_question
    click_button get_correct_answer(page)
    expect(page).to have_content 'Question 2'
  end
end
```

## Deployment

The app has not yet been deployed - this will be done once the styling of the app is complete.

## Built with

- Ruby
- Sinatra
- PostgreSQL
- Twitter

## License
