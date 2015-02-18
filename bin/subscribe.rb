require 'pusher-client'
require 'json'
require 'net/http'

options = { secure: true }
socket = PusherClient::Socket.new("baa5f875f299edd352bf", options)

socket.subscribe('apn')

socket['apn'].bind('message') do |data|
  begin
  uri = URI('http://pushitrealgood.dev/accounts/1/relay')
    http = Net::HTTP.new(uri.host, uri.port)

    req =  Net::HTTP::Post.new(uri)
    req.add_field "Content-Type", "text/json"
    req.body = data

    res = http.request(req)
    puts "Response HTTP Status Code: #{res.code}"
    puts "Response HTTP Response Body: #{res.body}"
  rescue Exception => e
    puts "HTTP Request failed (#{e.message})"
  end
end

socket.connect
