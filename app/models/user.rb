class User < ApplicationRecord
  validates_presence_of :api_key
  validates :email, uniqueness: {case_sensitive: false}, presence: true

  has_secure_password

  before_save { self.email = self.email.to_s.downcase }
end
