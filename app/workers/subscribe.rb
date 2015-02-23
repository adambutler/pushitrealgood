require 'json'

class Subscribe
  include Sidekiq::Worker

  def perform(id, key, account_uid)
    puts 'Subscribe'
    puts key

    options = { secure: true }
    socket = PusherClient::Socket.new(key, options)

    socket.subscribe('apn')

    socket['apn'].bind('message') do |data|
      @json = JSON.parse(data)
      @message = @json["message"]
      @app = App.find(id)

      @app.devices.each do |device|
        puts """
SENDING MESSAGE TO DEVICE
=========================
  token: #{device.token}
  message: #{@message}
  certificate: #{@app.apn_certificate}
"""
        APN.certificate = File.read(@app.apn_certificate)
        notification = Houston::Notification.new(device: device.token)
        notification.alert = @message
        APN.push(notification)
      end
    end

    socket.connect
  end
end
