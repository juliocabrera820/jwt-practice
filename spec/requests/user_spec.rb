# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :request do
  describe 'GET /users/:id' do
    it 'returns unauthorized status due to authorization header is missing' do
      get '/api/v1/users/1'
      expect(response).to have_http_status(:unauthorized)
    end
    let(:user) { FactoryBot.create(:user) }
    xit 'returns user data' do
      token = AuthenticationService.encode(user)
      get '/api/v1/users/6', headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(
        {
          'id' => 6,
          'email' => 'l@gmail.com'
        }
      )
    end
  end
end
