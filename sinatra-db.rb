require 'sinatra'
require 'mysql2'
require 'pry'

get '/events/new' do
  File.read('event_form.html')
end

post '/events' do
  temperature = db.escape(params[:temperature])
  time = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S")
  query = "INSERT INTO events (temperature, created_at) VALUES(#{temperature}, '#{time}')"
  db.query(query)
  redirect '/events/new'
end

get '/events' do
  events = db.query("SELECT * FROM events;").each
  erb :events_db, locals: { events: events }
end

def db
  @client ||= Mysql2::Client.new(:host => "localhost", 
                                 :database =>"prz_events", 
                                 :username =>ENV["DB_USER"], 
                                 :password =>ENV["DB_PASS"])
end
