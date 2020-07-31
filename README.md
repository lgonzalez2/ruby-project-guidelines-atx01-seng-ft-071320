# This is "BigBrain"

"BigBrain" is a simple and easy to understand command line prompt game that allows the user to be given 10 questions with 4 multiple choice answers to choose from. Depending on the question, the user can earn a certain amount of points, culminating with a high score. The user can create a username before starting the game, and thus allows the highscore to be tracked and viewed whenever the user wants. Additionally, the user is allowed to view a leaderboard that inclues the top 5 high scores.

## Requirements

### 1. Before loading and running this game, make sure you have the latest version of Ruby installed. This game was built using:

      ruby 2.6.1


### 2. Additionally, make sure you have the following gem dependencies, and install by running 'bundle install' from the command line:

    source "https://rubygems.org"

    gem "sinatra-activerecord"
    gem "sqlite3"
    gem "pry"
    gem "require_all"
    gem "rake"
    gem "tty-prompt"
    gem "colorize"

### 3. Before starting, run the following lines from the command line to initially set up the database and tables:

    rake db:drop
    rake db:migrate
    rake db:seed

### 4. To finally start the game, run the following from the command line:

    ruby bin/run.rb

---
### Contributors:
- Lucio Gonzalez 
- Philip Roush 

