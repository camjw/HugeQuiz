class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :first_answer
      t.string :second_answer
      t.string :third_answer
      t.integer :correct_answer

      t.timestamps
    end
  end
end
