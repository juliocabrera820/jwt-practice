# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Repository', type: :request do
  describe 'GET /users/:user_id/repositories' do
    it 'returns unauthorized status due to authorization header is missing' do
      get '/api/v1/users/1/repositories'
      expect(response).to have_http_status(:unauthorized)
    end
  end
  let(:user) { FactoryBot.create(:user) }
  xdescribe 'POST /users/:user_id/repositories' do
    it 'returns a new repository' do
      token = AuthenticationService.encode(user)
      post "/api/v1/users/#{user.id}/repositories", params: { name: 'demo', description: 'demo jwt', visible: true },
                                                    headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({ 'message' => 'repository successfully created' })
    end
  end
end
