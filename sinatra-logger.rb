require 'sinatra'

get '/events/new' do
  File.read('views/event_form.html')
end

post '/events' do
  temperature = params[:temperature]
  File.open('temperature.txt', 'a+') do |f|
    f.puts "#{Time.now} temperature=#{temperature}"
  end
  redirect '/events/new'
end

get '/events' do
  send_file('temperature.txt')
end
