require 'json'

class Subscribe
  include Sidekiq::Worker

  def perform(key, account_uid)
    puts 'Subscribe'
    puts key
    puts account_uid

    options = { secure: true }
    socket = PusherClient::Socket.new(key, options)

    socket.subscribe('apn')

    socket['apn'].bind('message') do |data|
      puts data
    end
      # @body = request.body.string
      # @json = JSON.parse(@body)
      # @message = @json["message"]

      # @app.devices.each do |device|
      #   Rails.logger.debug device.token
      #   APN.certificate = File.read("/Users/adambutler/Sites/pushitrealgood/public/cert.pem")
      #   notification = Houston::Notification.new(device: device.token)
      #   notification.alert = @message
      #   notification.badge = @json["badge"].to_i unless @json["badge"].nil?
      #   notification.sound = "alert.aiff"
      #   APN.push(notification)
      # end

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
