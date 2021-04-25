# frozen_string_literal: true

class Repository < ApplicationRecord
  validates :name, :description, presence: true
  belongs_to :user
end
