# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  SECRET = ENV['SECRET_JWT']

  def auth_header
    request.headers['Authorization']
  end

  def decode_token
    return nil unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, SECRET)[0]
    rescue JWT::ExpiredSignature
      invalid_token
    end
  end

  def current_user
    return unless decode_token

    user_id = decode_token[0]['user_id']
    User.find(user_id)
  end

  def logged_in?
    !!current_user
  end

  def encode(user_data)
    expiration_time = Time.now.to_i + 1 * 3600
    payload = { user_id: user_data.id, exp: expiration_time }
    JWT.encode(payload, SECRET)
  end

  def authorized
    render json: { message: 'please log in' }, status: :unauthorized unless logged_in?
  end

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def invalid
    render json: { message: 'record not valid' }, status: :unprocessable_entity
  end

  def invalid_token
    render json: { message: 'token is not valid' }, status: :unauthorized
  end
end
