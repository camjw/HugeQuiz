describe 'Question generation feature' do
  include Rack::Test::Methods

  def app
    QuizApp.new(getter: QuestionGetter.new(database: 'quiz_questions_test'))
  end

  feature 'The user sees a random first question' do
    scenario 'when they click the attempt button' do
      app.set_database_seed(0.02)
      attempt_first_question
      expect(page).to have_content 'How many holes does a polo have?'
    end
  end
end
