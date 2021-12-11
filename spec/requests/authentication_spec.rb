# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authentication/sign_up' do
    it 'returns a new user with valid data' do
      post '/api/v1/authentication/sign_up', params: { email: 'pekka@gmail.com', password: '12345' }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('id')
      expect(response.body).to include('email')
      expect(response.body).to include('password_digest')
      expect(response.body).to include('created_at')
      expect(response.body).to include('updated_at')
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
    let(:user) { FactoryBot.create(:user, email: 'fa@gmail.com', password: '12') }
    it 'generates a new token with valid data' do
      token = AuthenticationService.encode(user)
      post '/api/v1/authentication/sign_in', params: { email: 'fa@gmail.com', password: '12' }
      expect(response).to have_http_status(:success)
      expect(response.body).to eq(token)
    end
    FactoryBot.create(:user, email: 'll@gmail.com', password: '12')
    it 'does not generate a token due to wrong password' do
      post '/api/v1/authentication/sign_in', params: { email: 'll@gmail.com', password: '122' }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
