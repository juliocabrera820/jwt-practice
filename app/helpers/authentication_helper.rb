# frozen_string_literal: true

module AuthenticationHelper
  SECRET = ENV['SECRET_JWT']
  ALGORITHM_TYPE = ENV['ALGORITHM_TYPE']

  def encode(user_data)
    JWT.encode user_data, SECRET, ALGORITHM_TYPE
  end
end
