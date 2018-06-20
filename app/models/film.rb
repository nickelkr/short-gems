class Film < ApplicationRecord
  belongs_to :user
  has_many :applauses, dependent: :destroy

  validates :external_id, uniqueness: true
end
