# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    email { 'l@gmail.com' }
    password { '123' }
  end
end
