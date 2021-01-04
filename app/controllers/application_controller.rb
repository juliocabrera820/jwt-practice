# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def invalid
    render json: { message: 'record not valid' }, status: :unprocessable_entity
  end
end
