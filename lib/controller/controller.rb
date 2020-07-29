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
         binding.pry
    when "HighScore"

    when "Back"
        login
    else "Exit"
        exit
     end
    end

    

end