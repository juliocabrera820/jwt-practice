# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :set_user, only: [:sign_in]

      rescue_from ActiveRecord::RecordNotUnique, with: :not_unique
      rescue_from JWT::ExpiredSignature, with: :signature_error
      rescue_from JWT::DecodeError, with: :decode_error
      rescue_from JWT::VerificationError, with: :verification_error

      def sign_up
        user = User.new(user_params)
        if user.save
          render json: user, status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def sign_in
        return email_error unless @user
        return user_error unless @user.authenticate(params[:password])

        token = AuthenticationService.encode(@user)
        render json: token, status: :ok
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def set_user
        @user = UsersRepository.new.find_by_email(params[:email])
      end

      def not_unique
        render json: { message: 'email must be unique' }, status: :unprocessable_entity
      end

      def user_error
        render json: { message: 'password is wrong' }, status: :bad_request
      end

      def email_error
        render json: { message: 'email does not exist' }, status: :bad_request
      end

      def signature_error
        render json: { message: 'error with the signature' }, status: :bad_request
      end

      def decode_error
        render json: { message: 'decode error' }, status: :bad_request
      end

      def verification_error
        render json: { message: 'token is invalid' }, status: :bad_request
      end
    end
  end
end
