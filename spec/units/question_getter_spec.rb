require 'question_getter'

RSpec.describe QuestionGetter do
  before(:each) do
    initialize_test_questions_table
  end

  subject { described_class.new(database: 'quiz_questions_test') }

  it 'can read from a database of questions and return one as an array' do
    test_q = {
      'id' => '1',
      'question' => 'How many holes does a polo have?',
      'first_answer' => 'One',
      'second_answer' => 'Four',
      'third_answer' => 'Three',
      'correct_answer' => '1'
    }
    subject.give_random_seed(0.02) # Don't change this seed!
    expect(subject.new_question).to eq test_q
  end
end
