require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

require 'capybara'
require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require_relative '../app.rb'
require_relative 'features/web_helpers'
require_relative 'helper_methods'

ENV['RACK_ENV'] = 'test'
Capybara.app = QuizApp.new(
  getter: QuestionGetter.new(database: 'quiz_questions_test')
)

SimpleCov.formatter = SimpleCov::Formatter::Console

SimpleCov.start
