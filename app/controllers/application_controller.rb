# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :invalid
  rescue_from JWT::ExpiredSignature, with: :signature_error
  rescue_from JWT::DecodeError, with: :decode_error
  rescue_from JWT::VerificationError, with: :verification_error

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def invalid
    render json: { message: 'record not valid' }, status: :unprocessable_entity
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
