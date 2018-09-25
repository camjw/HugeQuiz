feature 'The user progresses' do
  scenario 'when they answer correctly' do
    attempt_first_question
    click_button get_correct_answer(page)
    expect(page).to have_content 'Question 2'
  end
end
