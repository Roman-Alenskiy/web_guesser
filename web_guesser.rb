require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)
get '/' do
    message = check_guess(params['guess'])
    erb :index, :locals => {:number => settings.number, :message => message}
end

def check_guess(guess)
    guess = guess.to_i
    return "You are close! (too high)" if (guess - settings.number).between?(1,5)
    return "You are close! (too low)" if (guess - settings.number).between?(-5,-1)
    return "Too high!" if guess > settings.number
    return "Too low!" if guess < settings.number
    return "You god damn right! The secret number is #{guess}" if guess == settings.number
end