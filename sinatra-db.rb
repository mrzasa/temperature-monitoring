require 'sinatra'
require 'mysql2'

get '/events/new' do
  File.read('event_form.html')
end

post '/events' do
  temperature = db.escape(params[:temperature])
  db.query(
    "INSERT INTO events (temperature, created_at) VALUES(#{temperature}, #{Time.now})")
  redirect '/events/new'
end

get '/events' do
  db.query(
    "SELECT * FROM events;")
end

def db
  @client ||= Mysql2::Client.new(:host => "localhost", 
                                 :database =>"prz_events", 
                                 :username =>ENV["DB_USER"], 
                                 :password =>ENV["DB_PASS"])
end
