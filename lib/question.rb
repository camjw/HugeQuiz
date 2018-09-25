require 'question_getter'

# This class takes a hash from the question_getter and returns information about
# the question. It also checks if the given answer is correct.
class Question
  def initialize(question_hash)
    @question_hash = question_hash
  end

  def give_question
    @question_hash['question']
  end

  def give_answers
    @question_hash.values_at('first_answer', 'second_answer', 'third_answer')
  end

  def check_answer(answer)
    answer == @question_hash['correct_answer'].to_i
  end

  def question_id
    @question_hash['id']
  end 
end
