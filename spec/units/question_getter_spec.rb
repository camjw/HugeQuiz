require 'question_getter'

RSpec.describe QuestionGetter do
  before(:each) do
    initialize_test_questions_table
  end

  subject { described_class.new(dbname: 'quiz_questions_test') }

  it 'can read from a database of questions and return one as an array' do
    test_q = ['How many holes does a polo have?', 'One', 'Four', 'Three', 1]
    expect(subject.new_question).to eq test_q
  end
end
