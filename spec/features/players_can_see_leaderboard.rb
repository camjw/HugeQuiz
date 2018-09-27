feature 'The user progresses' do
  scenario 'when they answer correctly' do
    initialize_test_leaderboard
    visit '/'
    click_button 'Leaderboard'
    ['Billy', 'Barry', 'Bertie'].each do |player|
      expect(page).to have_content player
    end 
  end
end
