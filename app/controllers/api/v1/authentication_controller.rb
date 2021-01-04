# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      rescue_from ActiveRecord::RecordNotUnique, with: :not_unique
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def sign_up
        @user = User.new(user_params)
        if @user.save!
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
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

      def not_found
        render json: { message: 'email not found' }, status: :unprocessable_entity
      end
    end
  end
end
