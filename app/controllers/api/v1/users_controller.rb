# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Authenticable
      before_action :authorize
      before_action :set_user, only: [:show]

      def show
        render json: UserPresenter.new(@user).as_json, status: :ok
      end

      private

      def authorize
        token = AuthenticationService.decode_token(request)
        return forbidden unless token
        return forbidden unless token['user_id'].to_s == params[:id]
      end

      def set_user
        @user = UsersRepository.new.show(params[:id])
      end

      def forbidden
        render json: { message: 'permission denied' }, status: :forbidden
      end
    end
  end
end
