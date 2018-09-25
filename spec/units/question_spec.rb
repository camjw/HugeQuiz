require 'question'

RSpec.describe Question do

  test_q = {
    'id' => '1',
    'question' => 'How many holes does a polo have?',
    'first_answer' => 'One',
    'second_answer' => 'Four',
    'third_answer' => 'Three',
    'correct_answer' => '1'
  }

  let(:fake_question_getter) { double :QuestionGetter, new_question: test_q }

  subject { described_class.new(getter: fake_question_getter) }

  before(:each) do
    initialize_test_questions_table
    set_random_seed(0)
  end

  it 'can interpret the question getters response and give a question string' do
    expect(subject.give_question).to eq 'How many holes does a polo have?'
  end

  it 'can give an array of answers' do
    expect(subject.give_answers).to eq ['One', 'Four', 'Three']
  end

  it 'can tell when an answer is incorrect' do
    expect(subject.check_answer(0)).to eq false
  end

  it 'can tell when an answer is incorrect' do
    expect(subject.check_answer(1)).to eq true
  end
end
