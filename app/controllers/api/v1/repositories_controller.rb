# frozen_string_literal: true

module Api
  module V1
    class RepositoriesController < ApplicationController
      include Authenticable
      before_action :authorize
      before_action :set_user

      def index
        render json: @user.repositories, status: :ok
      end

      def create
        @repository = Repository.new(repository_params)
        @repository.user_id = @user.id
        if @repository.save
          render json: @repository, status: :created
        else
          render json: @repository.error, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def authorize
        token = AuthenticationService.decode_token(request)
        return forbidden unless token['user_id'].to_s == params[:user_id]
      end

      def forbidden
        render json: { message: 'permission denied' }, status: :forbidden
      end

      def repository_params
        params.permit(:name, :description, :visible)
      end
    end
  end
end
