feature "The user sees the first question" do
  scenario "when they click the attempt button" do
    attempt_first_question
    expect(page).to have_content "How many holes does a polo have?"
  end
end
