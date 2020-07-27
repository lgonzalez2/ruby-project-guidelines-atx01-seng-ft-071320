class CreateGameQuestions < ActiveRecord::Migration[6.0]
    def change 
        create_table :game_questions do |t|
            t.integer :game_id
            t.integer :question_id
        end 
    end 
end 