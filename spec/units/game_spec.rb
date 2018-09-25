require 'game'

RSpec.describe Game do
  test_q = {
    'id' => '1',
    'question' => 'How many holes does a polo have?',
    'first_answer' => 'One',
    'second_answer' => 'Four',
    'third_answer' => 'Three',
    'correct_answer' => '1'
  }

  let(:fake_getter) { double :QuestionGetter, new_question: test_q }
  let(:fake_player) { double :Player, name: 'Billy' }

  subject { described_class.new(fake_player, getter: fake_getter) }

  it 'should instruct the getter to update the question' do
    subject.new_question
    expect(subject.current_question).to eq 'How many holes does a polo have?'
  end

  it 'should keep track of questions already asked' do
    subject.new_question
    expect(subject.asked_questions).to eq ['1']
  end

  it 'should instruct the player to keep track of score' do
    
  end

  it 'should ask the question if the answer is correct' do

  end
end
