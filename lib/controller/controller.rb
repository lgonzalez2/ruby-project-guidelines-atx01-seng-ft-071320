class Control 

    def intro 
        #banner/intro message
        self.welcome 
    end 

    def self.welcome 
        welcome_question = prompt.yes?("Welcome to Trivia Game! Are you a new user?")
        if welcome_question 
            User.create_username  
        else 
            Control.login
        end 
    end 

    def self.login
        login = prompt.select("Please select Login to continue!", %w(Login Back Exit))
        case login
        when "Login"
            User.find_username
        when "Back"
            Control.welcome
        else
            exit
        end 
    end 
end 




