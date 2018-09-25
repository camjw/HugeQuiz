describe 'Question generation feature' do
  include Rack::Test::Methods

  def app
    QuizApp.new(getter: QuestionGetter.new(database: 'quiz_questions_test'))
  end

  feature 'The user progresses' do
    scenario 'when they answer correctly' do
      app.set_database_seed(0.02)
      attempt_first_question
      click_button 'Four'
      expect(page).to have_content 'Question 2'
    end
  end
end
