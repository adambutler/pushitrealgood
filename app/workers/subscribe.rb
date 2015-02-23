require 'json'

class Subscribe
  include Sidekiq::Worker

  def perform(id, key, account_uid)
    puts 'Subscribe'
    puts key
    # puts account_uid

    options = { secure: true }
    socket = PusherClient::Socket.new(key, options)

    socket.subscribe('apn')

    socket['apn'].bind('message') do |data|
      @json = JSON.parse(data)
      @message = @json["message"]

      App.find(id).devices.each do |device|
        puts """
SENDING MESSAGE TO DEVICE
=========================
  token: #{device.token}
  message: #{@message}
"""
        # APN.certificate = File.read("/Users/adambutler/Sites/pushitrealgood/public/cert.pem")
        # notification = Houston::Notification.new(device: device.token)
        # notification.alert = @message
        # notification.badge = @json["badge"].to_i unless @json["badge"].nil?
        # notification.sound = "alert.aiff"
        # APN.push(notification)
      end
    end

    socket.connect



      # begin
      # uri = URI('http://pushitrealgood.dev/accounts/#{account_uid}/relay')
      #   http = Net::HTTP.new(uri.host, uri.port)

      #   req =  Net::HTTP::Post.new(uri)
      #   req.add_field "Content-Type", "text/json"
      #   req.body = data

      #   res = http.request(req)
      #   puts "Response HTTP Status Code: #{res.code}"
      #   puts "Response HTTP Response Body: #{res.body}"
      # rescue Exception => e
      #   puts "HTTP Request failed (#{e.message})"
      # end
    # end

    # socket.connect
  end
end
