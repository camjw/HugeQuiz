feature "The user is congratulated" do
  scenario "when they answer correctly" do
    attempt_first_question
    fill_in(:answer, with: 'Four')
    click_button 'Answer!'
    expect(page).to have_content "Well done! That's the correct answer!"
  end
end
