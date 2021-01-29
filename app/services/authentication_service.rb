# frozen_string_literal: true

class AuthenticationService
  SECRET = ENV['SECRET_JWT']

  def self.decode_token(request)
    token = request.headers['Authorization'].split(' ')[1]

    begin
      JWT.decode(token, SECRET)[0]
    rescue JWT::DecodeError
      nil
    rescue JWT::ExpiredSignature
      nil
    end
  end

  def self.encode(user_data)
    expiration_time = Time.now.to_i + 1 * 3600
    payload = { user_id: user_data.id, exp: expiration_time }
    JWT.encode(payload, SECRET)
  end
end
