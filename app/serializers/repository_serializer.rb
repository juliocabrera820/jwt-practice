# frozen_string_literal: true

class RepositorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :visible
end
