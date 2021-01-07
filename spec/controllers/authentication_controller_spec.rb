# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  describe 'POST /authentication/sign_up' do
    it 'permits email and password' do
      params = { email: 'pekka@gmail.com', password: '12345' }
      should permit(:email, :password).for(:sign_up, verb: :post, params: params)
    end
    it 'does not permit name' do
      params = { email: 'pekka@gmail.com', password: '12345', name: 'al' }
      should_not permit(:name).for(:sign_up, verb: :post, params: params)
    end
  end
  describe 'POST /authentication/sign_in' do
    it { should use_before_action(:set_user) }
    it do
      should rescue_from(ActiveRecord::RecordNotUnique).with(:not_unique)
    end
    it do
      should rescue_from(ActionController::ParameterMissing).with(:parameter_missing)
    end
  end
end
