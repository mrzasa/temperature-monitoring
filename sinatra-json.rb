require 'sinatra'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(:adapter => 'mysql2',
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
  temperature = params[:temperature]
  if request.content_type == 'application/json'
    params_json = JSON.parse(request.body.read)
    temperature = params_json['temperature']
  end
  Event.create(temperature: temperature)
  redirect '/events/new'
end

get '/events' do
  events = Event.all
  erb :events_ar, locals: { events: events }
end
