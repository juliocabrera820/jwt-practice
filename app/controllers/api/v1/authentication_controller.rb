# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authorized, only: [:sign_up, :sign_in]
      before_action :set_user, only: [:sign_in]

      rescue_from ActiveRecord::RecordNotUnique, with: :not_unique

      def sign_up
        @user = User.new(user_params)
        if @user.save!
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def sign_in
        return user_error unless @user.email == params[:email] && @user.authenticate(params[:password])

        token = encode(@user)
        render json: token, status: :ok
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def set_user
        @user = User.find_by(email: params[:email])
      end

      def not_unique
        render json: { message: 'email must be unique' }, status: :unprocessable_entity
      end

      def user_error
        render json: { message: 'password is wrong' }, status: :bad_request
      end
    end
  end
end
