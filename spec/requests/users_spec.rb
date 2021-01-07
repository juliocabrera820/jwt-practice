# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authentication/sign_up' do
    it 'returns a new user with valid data' do
      post '/api/v1/authentication/sign_up', params: { email: 'pekka@gmail.com', password: '12345' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(
        {
          'id' => 2,
          'email' => 'pekka@gmail.com'
        }
      )
    end
    it 'returns an unprocessable entity status with empty password' do
      post '/api/v1/authentication/sign_up', params: { email: 'pekka@gmail.com', password: '' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'returns an unprocessable entity status because parameter are missing' do
      post '/api/v1/authentication/sign_up', params: { email: 'pekka@gmail.com' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe 'POST /authentication/sign_in' do
    let(:user) { FactoryBot.create(:user) }
    it 'generates a new token with valid data' do
      expiration_time = Time.now.to_i + 1 * 3600
      payload = { user_id: user.id, exp: expiration_time }
      token = JWT.encode(payload, ApplicationController::SECRET)
      post '/api/v1/authentication/sign_in', params: { email: 'l@gmail.com', password: '123' }
      expect(response).to have_http_status(:success)
      expect(response.body).to eq(token)
    end
    FactoryBot.create(:user, email: 'll@gmail.com', password: '12')
    it 'does not generate a token with wrong password' do
      post '/api/v1/authentication/sign_in', params: { email: 'll@gmail.com', password: '122' }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
