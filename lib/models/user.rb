class User < ActiveRecord::Base
    has_many :games

    def self.create_username
        new_user = User.new_user
        new_user
        
    end
    def self.new_user
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        initial_name = PROMPT.ask("What would you like your user name to be?".colorize(:light_cyan), required: true)
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        confirm = PROMPT.yes?("#{initial_name} is correct?".colorize(:light_cyan))
        if confirm
            if User.find_by(name: initial_name) == nil
                User.create(name: initial_name)
            else
                puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
                PROMPT.ok("Sorry! That user name is taken!")
                User.new_user
            end
        end
    end
    def self.find_username(controller_instance)
        # include option to go back
        puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
        user_name = PROMPT.ask("What is your user name?:".colorize(:light_cyan), required: true)
        possible_user = User.find_by(name: user_name)
        if possible_user == nil
            puts "---------------------------------------------------------------------------------------------------------".colorize(:red)
            PROMPT.ok("Sorry! That user name doesn’t exist! Please try again!")
            User.find_username(controller_instance)
        else
            possible_user
            
        end
    end
end