feature 'The user sees a random first question' do
  scenario 'when they click the attempt button' do
    attempt_first_question
    expect(page).to have_content 'Question 1:'
  end
end
