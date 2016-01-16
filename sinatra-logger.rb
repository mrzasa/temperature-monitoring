require 'sinatra'

get '/events/new' do
  File.read('event_form.html')
end

post '/events' do
  File.open('temperature.txt', 'a+') do |f|
    f.puts "#{Time.now} temperature=#{params[:temperature]}"
  end
  redirect '/events/new'
end

get '/events' do
  send_file('temperature.txt')
end
