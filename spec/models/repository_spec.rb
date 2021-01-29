# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:visible) }
  end
  describe 'associations' do
    it { should belong_to(:user) }
  end
end
