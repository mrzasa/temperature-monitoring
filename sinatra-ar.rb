require 'sinatra'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
  :adapter => 'mysql2',
  :host => "localhost", 
  :database =>"prz_events", 
  :username =>ENV["DB_USER"], 
  :password =>ENV["DB_PASS"])

class Event < ActiveRecord::Base
end

get '/events/new' do
  File.read('views/event_form.html')
end

post '/events' do
  Event.create(temperature: params[:temperature])
  redirect '/events/new'
end

get '/events' do
  temp = params[:temp]
  events = Event.where('temperature > ?', temp)
  erb :events_ar, locals: { events: events }
end
