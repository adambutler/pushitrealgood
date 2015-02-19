class Account < ActiveRecord::Base
  extend FriendlyId
  friendly_id :uid

  has_many :devices

  before_create :generate_uid, on: :create

  protected

  def generate_uid
    self.uid = loop do
      random_uid = SecureRandom.urlsafe_base64(nil, false)
      break random_uid unless Account.exists?(uid: random_uid)
    end
  end
end
