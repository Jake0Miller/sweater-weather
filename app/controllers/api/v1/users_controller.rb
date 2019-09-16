class Api::V1::UsersController < ApplicationController
  def new
    user = User.new(user_params)
    user.update(api_key: SecureRandom.hex(13))
    if params[:password] == params[:password_confirmation] && user.save
      render json: {api_key: user.api_key}, status: 201
    else
      render json: 'Hello world'
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
