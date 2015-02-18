class Account < ActiveRecord::Base
  has_many :devices
end
