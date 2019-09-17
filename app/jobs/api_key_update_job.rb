class ApiKeyUpdateJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      user.update_attributes(api_key: SecureRandom.hex(13))
    end
  end
end
