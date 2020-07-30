class Control

    attr_accessor :current_user, :score, :current_game, :current_game_questions

    def initialize
      @current_user = nil
      @score = 0
      @current_game = nil
      @current_game_questions = nil
    end
    # need to find command that allows selections to have a space******
    # 
    def intro
        #welcome banner
        welcome
    end
    def welcome
        welcome_question = PROMPT.yes?("Welcome to Trivia Game! Are you a new user?")
        if welcome_question
            @current_user = User.create_username
            login
        else
            login
        end
    end
    def login
        login = PROMPT.select("Please select Login to continue!", %w(Login Back Exit))
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
    main = PROMPT.select("Please select from following qptions to continue!", %w(NewGame HighScore Back Exit))
    case main
    when "NewGame"
         @current_game = Game.new_game(@current_user)
         @current_game_questions = GameQuestion.create_game_questions(@current_game)
         game_instructions(@current_game_questions)
         


         
    when "HighScore"
        # create highscore method!!!!
    when "Back"
        login
    else "Exit"
        exit
     end
    end

    def game_instructions(current_game_questions)
        instructions = PROMPT.select("Welcome to Trivia game! You'll be given 10 questions that include the category... 
If you select the correct answer, you will be awarded 100 points! Try to beat your high score! Ready!?", %w(Start Back Exit))
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
        
        # We want a question to appear with 1 correct answer and 3 incorrect
        # If user selects the correct answer, 100 points will be added to @score 
        # It will then trigger a prompt/alert letting them know if they got the question correct or incorrect
        #   -if/else statement
        # Stretch goal - score will be present in the terminal and will be updated with current score amount
        # Have the total score show on screen and if its a new high score, inform the user.
        # create a method for highscore
        # ask them what they want to do next-- new game, back, high score, exit.
        first_question(current_game_questions)
    end

    def first_question(current_game_questions)
        first = Question.find(current_game_questions.question_id_one)
        options = Answer.where(question_id: first.id).shuffle
        options_answers = options.pluck(:answer, :correct)
        value = PROMPT.select("Question #1...Category: #{first.category}
        
#{first.question}") do |option|
option.choice options_answers[0][0]
option.choice options_answers[1][0]
option.choice options_answers[2][0]
option.choice options_answers[3][0]

    end
            
#         binding.pry
#         value = PROMPT.enum_select("Question #1...Category: #{first.category}
        
# #{first.question}", options_answers)
        
        


    end

    

end