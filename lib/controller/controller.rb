class Control

    attr_accessor :current_user, :score, :current_game, :current_game_questions

    def initialize
      @current_user = nil
      @current_game = nil
      @current_game_questions = nil
    end
   
    def intro
        Images.intro_banner
        welcome
        
    end
    def welcome
        welcome_question = PROMPT.yes?("Welcome to BigBrain! Are you a new user?".colorize(:light_cyan))
        
    if welcome_question
        @current_user = User.create_username
        login
    else
        login
        end
    end
    def login
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        login = PROMPT.select("Please select Login to continue!".colorize(:light_cyan), %w(Login Back Exit))
    case login
    when "Login"
            @current_user = User.find_username(self)
            main_menu
    when "Back"
            welcome
    else
            exit
        end
    end

    def main_menu
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
    main = PROMPT.select("Please select from following options to continue!".colorize(:light_cyan), %w(NewGame HighScore Leaderboard Back Exit))
    case main
    when "NewGame"
         @current_game = Game.new_game(@current_user)
         @current_game_questions = GameQuestion.create_game_questions(@current_game)
         game_instructions(@current_game_questions)
    when "HighScore"
        display_high_score(current_user)
    when "Leaderboard"
        leaderboard
    when "Back"
        login
    else "Exit"
        exit
     end
    end

    def display_high_score(current_user)
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        show_high_score = PROMPT.select("Your high score is #{current_user.high_score}!".colorize(:green), %w(Back Exit))
    case show_high_score
    when "Back"
        main_menu
    else "Exit"
        exit
     end
    end

    def leaderboard
        
        leader = User.order(high_score: :desc).limit(5).pluck(:name, :high_score)
        Images.leader_banner
        
        if leader.length == 1
            puts "1. #{leader[0][0]} with a high score of #{leader[0][1]}".colorize(:light_cyan)
        elsif leader.length == 2
            puts "1. #{leader[0][0]} with a high score of #{leader[0][1]}".colorize(:light_cyan)
            puts "2. #{leader[1][0]} with a high score of #{leader[1][1]}".colorize(:light_cyan)
        elsif leader.length == 3
            puts "1. #{leader[0][0]} with a high score of #{leader[0][1]}".colorize(:light_cyan)
            puts "2. #{leader[1][0]} with a high score of #{leader[1][1]}".colorize(:light_cyan)
            puts "3. #{leader[2][0]} with a high score of #{leader[2][1]}".colorize(:light_cyan)
        elsif leader.length == 4
            puts "1. #{leader[0][0]} with a high score of #{leader[0][1]}".colorize(:light_cyan)
            puts "2. #{leader[1][0]} with a high score of #{leader[1][1]}".colorize(:light_cyan)
            puts "3. #{leader[2][0]} with a high score of #{leader[2][1]}".colorize(:light_cyan)
            puts "4. #{leader[3][0]} with a high score of #{leader[3][1]}".colorize(:light_cyan)
        elsif leader.length == 5
            puts "1. #{leader[0][0]} with a high score of #{leader[0][1]}".colorize(:light_cyan)
            puts "2. #{leader[1][0]} with a high score of #{leader[1][1]}".colorize(:light_cyan)
            puts "3. #{leader[2][0]} with a high score of #{leader[2][1]}".colorize(:light_cyan)
            puts "4. #{leader[3][0]} with a high score of #{leader[3][1]}".colorize(:light_cyan)
            puts "5. #{leader[4][0]} with a high score of #{leader[4][1]}".colorize(:light_cyan)
        end 
    
        back_to = PROMPT.select("", %w(Back Exit))
        case back_to
        when "Back"
            main_menu
        else "Exit"
            exit
         end
        
        
        

    end 

    def game_instructions(current_game_questions)
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        instructions = PROMPT.select("Welcome to BigBrain! Here, you'll be given 10 questions that include the category... 
If you select the correct answer, you will be awarded a certain amount of points...
The higher the question, the highter the points!!! Ready to start!?".colorize(:light_cyan), %w(Start Back Exit))
        case instructions
        when "Start"
            trivia_game(current_game_questions)   
        when "Back"
            main_menu
        else "Exit"
            exit
        end
    end

   
    def trivia_game(current_game_questions)
        first_question(current_game_questions)
    end

    def first_question(current_game_questions)
        current_score = 0
        first = Question.find(current_game_questions.question_id_one)
        options = Answer.where(question_id: first.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #1...Category: #{first.category}
#{first.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]

        end
        if value == correct_answer
        current_score += 100
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        second_question(current_game_questions, current_score)
        else
        current_score 
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        second_question(current_game_questions, current_score)
        end
    end

    def second_question(current_game_questions, current_score)
        second = Question.find(current_game_questions.question_id_two)
        options = Answer.where(question_id: second.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #2...Category: #{second.category}
#{second.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]

        end
        if value == correct_answer
        current_score += 200
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        third_question(current_game_questions, current_score)
        else
        current_score 
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        third_question(current_game_questions, current_score)
        end
    end

    def third_question(current_game_questions, current_score)
        third = Question.find(current_game_questions.question_id_three)
        options = Answer.where(question_id: third.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #3...Category: #{third.category}
#{third.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]

        end
        if value == correct_answer
        current_score += 300
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        forth_question(current_game_questions, current_score)
        else
        current_score 
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        forth_question(current_game_questions, current_score)
        end
    end

    def forth_question(current_game_questions, current_score)
        forth = Question.find(current_game_questions.question_id_four)
        options = Answer.where(question_id: forth.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #4...Category: #{forth.category}
#{forth.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]

        end
        if value == correct_answer
        current_score += 400
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        fifth_question(current_game_questions, current_score)
        else
        current_score 
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        fifth_question(current_game_questions, current_score)
        end
    end

    def fifth_question(current_game_questions, current_score)
        fifth = Question.find(current_game_questions.question_id_five)
        options = Answer.where(question_id: fifth.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #5...Category: #{fifth.category}
#{fifth.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]

        end
        if value == correct_answer
        current_score += 500
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        sixth_question(current_game_questions, current_score)
        else
        current_score 
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        sixth_question(current_game_questions, current_score)
        end
    end

    def sixth_question(current_game_questions, current_score)
        sixth = Question.find(current_game_questions.question_id_six)
        options = Answer.where(question_id: sixth.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #6...Category: #{sixth.category}
#{sixth.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]

        end
        if value == correct_answer
        current_score += 500
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        seventh_question(current_game_questions, current_score)
        else
        current_score 
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        seventh_question(current_game_questions, current_score)
        end
    end
    
    def seventh_question(current_game_questions, current_score)
        seventh = Question.find(current_game_questions.question_id_seven)
        options = Answer.where(question_id: seventh.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #7...Category: #{seventh.category}
#{seventh.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]
        end
        if value == correct_answer
        current_score += 500
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        eighth_question(current_game_questions, current_score)
        else
        current_score
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        eighth_question(current_game_questions, current_score)
        end
    end

    def eighth_question(current_game_questions, current_score)
        eighth = Question.find(current_game_questions.question_id_eight)
        options = Answer.where(question_id: eighth.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #8...Category: #{eighth.category}
#{eighth.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]
        end
        if value == correct_answer
        current_score += 500
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        ninth_question(current_game_questions, current_score)
        else
        current_score
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        ninth_question(current_game_questions, current_score)
        end
    end

    def ninth_question(current_game_questions, current_score)
        ninth = Question.find(current_game_questions.question_id_nine)
        options = Answer.where(question_id: ninth.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        value = PROMPT.select("Question #9...Category: #{ninth.category}
#{ninth.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]
        end
        if value == correct_answer
        current_score += 500
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        tenth_question(current_game_questions, current_score)
        else
        current_score
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        tenth_question(current_game_questions, current_score)
        end
    end

    def tenth_question(current_game_questions, current_score)
        tenth = Question.find(current_game_questions.question_id_ten)
        options = Answer.where(question_id: tenth.id)
        correct_answer = options[0].answer
        shuffle_answers = []
        options.each do |option|
            shuffle_answers << option.answer
        end
        shuffle_answers = shuffle_answers.shuffle
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        puts "Bonus Round!!!! This question is worth 1000 points!!!".light_yellow.blink
        value = PROMPT.select("Question #10...Category: #{tenth.category}
#{tenth.question}".colorize(:light_cyan)) do |option|
option.choice shuffle_answers[0]
option.choice shuffle_answers[1]
option.choice shuffle_answers[2]
option.choice shuffle_answers[3]
        end
        if value == correct_answer
        current_score += 1000
        correct_response = PROMPT.ok("Nice! You choose the correct answer! Your current score is now #{current_score}!")
        ending_message(current_score)
        else
        current_score
        incorrect_response = PROMPT.ok("Whoops! That is incorrect! The correct answer is #{correct_answer}! Your current score is now #{current_score}!")
        ending_message(current_score)
        end
    end

    def ending_message(current_score)
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
    ending = PROMPT.ok("Congratulations! You've finished this round of BigBrain! Your final score is #{current_score}!!")
    set_high_score(current_score)
    main_menu
    end

    def set_high_score(current_score)
        
    if current_user.high_score < current_score
            current_user.high_score = current_score
            current_user.save
            high_score_prompt = PROMPT.ok("You've have beaten your personal high score!!!")
     end
        current_high_score = PROMPT.ok("Your current high score is #{current_user.high_score}!")
    end

end