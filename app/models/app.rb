class App < ActiveRecord::Base
  extend FriendlyId
  friendly_id :uid

  validates_uniqueness_of :key, :secret

  mount_uploader :apn_certificate, CertificateUploader

  has_many :devices
  belongs_to :user

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
    Subscribe.perform_async(id, key, uid)
  end
end
