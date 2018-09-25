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
end
