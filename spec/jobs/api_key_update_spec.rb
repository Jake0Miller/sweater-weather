require 'rails_helper'

describe ApiKeyUpdateJob, type: :job do
  it 'destroys all image resources' do
    user_1 = User.create!(email: 'w@e.com', password: 'pw', api_key: SecureRandom.hex(13))
    user_2 = User.create!(email: 'y@s.com', password: 'pw', api_key: SecureRandom.hex(13))
    api_1 = user_1.api_key
    api_2 = user_2.api_key

    expect(User.count).to eq(2)

    ApiKeyUpdateJob.perform_now

    expect(User.count).to eq(2)
    user_1.reload
    user_2.reload
    expect(user_1.api_key).to_not eq(api_1)
    expect(user_1.api_key).to_not eq(nil)
    expect(user_1.api_key).to be_a(String)
    expect(user_2.api_key).to_not eq(api_2)
    expect(user_2.api_key).to be_a(String)
    expect(user_2.api_key).to_not eq(user_1.api_key)
  end
end
