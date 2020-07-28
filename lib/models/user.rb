class User < ActiveRecord::Base 
    has_many :games 

    def self.create_username
        new_user = User.find_user
        new_user
    end


    def self.find_user
        initial_name = prompt.ask("What would you like your user name to be???", required: true)
        confirm = prompt.yes?("#{initial_name} is correct?") do |p|
            p.suffix 'Y/N'
        end

        if confirm
            if User.find_by(name: initial_name) == nil
                User.create(name: initial_name)
            else
                prompt.ok("Sorry! That user name is taken!")
                User.find_user
            end 
        end
    end


    def self.find_username 
        #Write a method that has the ability to see if the username has been created already 
        user_name = prompt.ask("What is your user name", required: true)
        if User.find_by(name: user_name) == nil 
            prompt.ok("Sorry! That user name doesn't exist! Please try again!")
            User.find_username
        else 
            #main menu method 
        end 
    end 
end 