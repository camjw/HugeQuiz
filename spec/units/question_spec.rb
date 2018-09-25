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

  subject { described_class.new(test_q) }

  it 'can interpret the question getters response and give a question string' do
    expect(subject.give_question).to eq 'How many holes does a polo have?'
  end

  it 'can give an array of answers' do
    expect(subject.give_answers).to eq %w[One Four Three]
  end

  it 'can return the id of the question' do
    expect(subject.question_id).to eq '1'
  end

  it 'can tell when an answer is incorrect' do
    expect(subject.correct_answer?(0)).to eq false
  end

  it 'can tell when an answer is incorrect' do
    expect(subject.correct_answer?(1)).to eq true
  end
end
