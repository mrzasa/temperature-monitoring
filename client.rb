require 'net/http'

def measure
  rand * 100
end

def send(temperature)
  http = Net::HTTP.new('localhost', 4567)
  http.set_debug_output($stdout)
  req = Net::HTTP::Post.new(
    '/events', 
    initheader={'Content-Type'=> 'application/json'})
  req.body = "{ \"temperature\": #{temperature} }"
  resp = http.request(req)
end

def run
  while true
    send(measure)
    sleep 1
  end
end

run
