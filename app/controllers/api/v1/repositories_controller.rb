# frozen_string_literal: true

module Api
  module V1
    class RepositoriesController < ApplicationController
      include Authenticable
      before_action :authorize

      def index
        render json: RepositoriesRepository.new.all(params[:user_id]), status: :ok
      end

      def create
        if RepositoriesRepository.new.create(params[:user_id], repository_params)
          render json: { message: 'repository successfully created' }, status: :created
        else
          render json: @repository.error, status: :unprocessable_entity
        end
      end

      def show
        repository = RepositoriesRepository.new.show(params[:user_id], params[:id])
        render json: repository, status: :ok
      end

      private

      def authorize
        token = AuthenticationService.decode_token(request)
        return forbidden unless token
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
