# frozen_string_literal: true

class Flat < ApplicationRecord
  validates :immo_id, presence: true, uniqueness: true
end
