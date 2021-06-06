# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern
  SECRET = ENV['SECRET_JWT']

  included do
    before_action :authenticate
  end

  def auth_header
    request.headers['Authorization']
  end

  def authenticate
    return unauthorized unless auth_header
  end

  def unauthorized
    render json: { message: 'please log in' }, status: :unauthorized
  end
end
