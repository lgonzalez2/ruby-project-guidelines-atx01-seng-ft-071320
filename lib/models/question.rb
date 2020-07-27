class Question < ActiveRecord::Base 
    has_many :answers 
    has_many :game_questions
    has_many :games, through: :game_questions
end 