class CreateQuestions < ActiveRecord::Migration[6.0]
    def change 
        create_table :questions do |t|
            t.string :category
            t.string :question
             
        end 
    end 
end 