class App < ActiveRecord::Base
  extend FriendlyId
  friendly_id :uid

  has_many :devices

  before_create :generate_uid, on: :create
  after_create :listen_for_events, on: :create

  protected

  def generate_uid
    self.uid = loop do
      random_uid = SecureRandom.urlsafe_base64(nil, false)
      break random_uid unless App.exists?(uid: random_uid)
    end
  end

  def listen_for_events
    Subscribe.perform_async(key, uid)
  end
end
