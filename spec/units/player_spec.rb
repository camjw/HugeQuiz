require 'player'

RSpec.describe Player do
  subject { described_class.new('Billy') }

  it 'should have a name' do
    expect(subject.name).to eq 'Billy'
  end

  it 'should keep track of score' do
    subject.score_point
    expect(subject.score).to eq 1
  end

  it 'should let the user lose lives' do
    subject.lose_life
    expect(subject.lives).to eq 2
  end

  it 'should let the user gam lives' do
    subject.gain_life
    expect(subject.lives).to eq 4
  end
end
