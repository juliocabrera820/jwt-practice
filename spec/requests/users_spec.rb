# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authentication/sign_up' do
    it 'returns a new user' do
      post '/api/v1/authentication/sign_up', params: { email: 'pekka@gmail.com', password: '12345' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(
        {
          'id' => 1,
          'email' => 'pekka@gmail.com'
        }
      )
    end
    it 'returns an unprocessable entity status' do
      post '/api/v1/authentication/sign_up', params: { email: 'pekka@gmail.com', password: '' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
