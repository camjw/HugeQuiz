require 'game'

test_q = {
  'id' => '1',
  'question' => 'How many holes does a polo have?',
  'first_answer' => 'One',
  'second_answer' => 'Four',
  'third_answer' => 'Three',
  'correct_answer' => '1'
}

RSpec.describe Game do
  let(:fake_getter) do
    double :QuestionGetter, new_question: test_q, total_questions: 3
  end
  let(:fake_question) do
    double :Question, question_id: '1', correct_answer?: true
  end
  let(:fake_question_type) { double :QuestionClass, new: fake_question }
  let(:fake_player) { double :Player, name: 'Billy', score_point: 'point' }

  subject do
    described_class.new(
      fake_player,
      getter: fake_getter,
      question_type: fake_question_type
    )
  end

  before(:each) do
    subject.new_question
  end

  describe 'interactions with the question getter' do
    it 'should instruct the getter to update the question' do
      expect(subject.current_question).to eq fake_question
    end

    it 'knows how many questions there are in the database' do
      expect(subject.total_questions).to eq 3
    end
  end

  it 'should keep track of questions already asked' do
    expect(subject.asked_questions).to eq ['1']
  end

  it 'can play the game' do
    expect(subject.play_game(1)).to eq true
  end
end
