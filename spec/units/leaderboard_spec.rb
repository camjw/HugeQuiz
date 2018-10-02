require 'leaderboard'

RSpec.describe Leaderboard do

  it 'can get the total number of players in the leaerboard' do
    expect(subject.total_players).to eq 2
  end
end
