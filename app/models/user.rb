require 'securerandom'

class User < ApplicationRecord
  validates_presence_of :password_digest, :api_key
  validates :email, uniqueness: {case_sensitive: false}, presence: true

  has_secure_password
end
