feature 'The user sees a random first question' do
  scenario 'when they click the attempt button' do
    srand(0)
    attempt_first_question
    expect(page).to have_content 'How many holes does a polo have?'
  end
end

feature 'The user sees a random do question' do
  scenario 'when they click the attempt button' do
    srand(1)
    attempt_first_question
    test_q = 'In West Side Story, which of these is the name of one of the'\
     ' gangs?'
    expect(page).to have_content test_q
  end
end
