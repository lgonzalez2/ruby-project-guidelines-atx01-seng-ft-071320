require 'net/http'
require 'open-uri'
require 'json'

class Question < ActiveRecord::Base 
    has_many :answers 
    has_many :game_questions
    has_many :games, through: :game_questions

    # URL = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
 
    # def get_all_questions
      
    #   uri = URI.parse(URL)
    #   response = Net::HTTP.get_response(uri)
    #   response.body
    # end
  
    # def create_questions
    #   everything = get_all_questions
    #   all_questions = JSON.parse(everything)
    #   all_questions.each do |questions_hash|
    #   category = questions_hash["category"]
    #   question = questions_hash["question"]
    #   correct_answer = questions_hash["correct answer"]
    #   incorrect_answer = questions_hash["incorrect answer"]
    #   self.find_or_create_by(category: category, question: question, correct_answer: correct_answer, incorrect_answer: incorrect_answer)
  
    #     end
    # end
end 