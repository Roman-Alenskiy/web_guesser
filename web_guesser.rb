require 'sinatra'
require 'sinatra/reloader'

get '/' do
    x = rand(101)
    "The SECRET number is #{x}"
end