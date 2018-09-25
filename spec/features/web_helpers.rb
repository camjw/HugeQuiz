require 'pg'

def attempt_first_question
  visit '/'
  click_button 'Play!'
end

def get_correct_answer(page)
  answers = %w[Four Sharks Hairspray]
  answers.each do |answer|
    return answer if page.has_selector?("input[type='submit']"\
      "[value='#{answer}']")
  end
end
