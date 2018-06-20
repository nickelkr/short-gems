class Film < ApplicationRecord
  belongs_to :user

  validates :external_id, uniqueness: true
end
