class Api::V1::UsersController < ApplicationController
  def new
    user = User.new(user_params)
    user.update(api_key: SecureRandom.hex(13))
    if user.save
      render json: {api_key: user.api_key}, status: 201
    else
      render json: {error: user.errors.full_messages.join('. ')}, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
