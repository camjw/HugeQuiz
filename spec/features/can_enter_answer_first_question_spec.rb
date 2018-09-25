feature 'The user is congratulated' do
  scenario 'when they answer correctly' do
    attempt_first_question
    click_button 'Four'
    expect(page).to have_content 'Question 2'
  end
end
