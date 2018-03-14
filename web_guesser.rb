require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)
disable :is_guessed
@@attempts = 6
get '/' do       
    
    if @@attempts == 0
        @@attempts = 5
        message = "All attempts are exhausted! New number was succesfully generated!"
        settings.number = rand(100)
    else
        message = check_guess(params['guess'])
        @@attempts -= 1
    end
    if settings.is_guessed
        settings.number = rand(100)
        @@attempts = 5
        settings.is_guessed = false
    end
    erb :index, :locals => {:number => settings.number, :message => message, :attempts => @@attempts}
end

def check_guess(guess)
    return "" if guess == ""
    guess = guess.to_i
    return "" if guess == 0
    return "You are close! (too high)" if (guess - settings.number).between?(1,5)
    return "You are close! (too low)" if (guess - settings.number).between?(-5,-1)
    return "Too high!" if guess > settings.number
    return "Too low!" if guess < settings.number
    if guess == settings.number
        settings.is_guessed = true
        return "You god damn right! The secret number is #{guess}. New number was sucessfully generated!" 
    end
end