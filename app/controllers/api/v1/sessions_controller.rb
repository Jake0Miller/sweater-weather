class Api::V1::SessionsController < ApplicationController
  def new
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:session][:password])
      render json: {api_key: user.api_key}
    else
      render json: {error: 'Username/password do not match'}, status: 401
    end
  end
end
