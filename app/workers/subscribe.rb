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
      end
    end

    socket.connect
  end
end
