# frozen_string_literal: true

class Repository < ApplicationRecord
  validates :name, :description, :visible, presence: true
  belongs_to :user
end
