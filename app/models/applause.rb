class Applause < ApplicationRecord
  belongs_to :film
  belongs_to :user

  validates :category, inclusion: {
    in: %w[directing story cinematography sound acting],
    message: "%{value} is not a valid category"
  }
end
