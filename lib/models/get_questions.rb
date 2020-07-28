require 'net/http'
require 'open-uri'
require 'json'

class GetQandA

  URL = "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"
 
  def self.get_all_questions
      
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def create_questions
    everything = GetQandA.get_all_questions
    all_questions = JSON.parse(everything)
    all_questions["results"].each do |questions_hash|
      category = questions_hash["category"]
      question = questions_hash["question"]
      content = Question.find_or_create_by(category: category, question: question)
      self.create_answers(content, questions_hash)
    end
  end

    def create_answers(content, questions_hash)
      answer = questions_hash["correct_answer"]
      answer_row = Answer.find_or_create_by(answer: answer, question_id: content.id, correct: true)
      questions_hash["incorrect_answers"].each do |inc_answer|
        Answer.find_or_create_by(answer: inc_answer, question_id: content.id)
      end
    end
end

