feature "The user sees the first question" do
  scenario "when they click the attempt button" do
    attempt_first_question
    fill_in(:answer, with: 'Four')
  end
end
