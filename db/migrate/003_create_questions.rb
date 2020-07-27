class CreateQuestions < ActiveRecord::Migration[6.0]
    def change 
        create_table :questions do |t|
            t.string :category
            t.string :question
            t.boolean :correct_answer, :default => true 
            t.boolean :incorrect_answer_0, :default => false 
            t.boolean :incorrect_answer_1, :default => false 
            t.boolean :incorrect_answer_2, :default => false 
        end 
    end 
end 