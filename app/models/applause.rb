class Applause < ApplicationRecord
  belongs_to :film
  belongs_to :user

  validates :category, presence: true
  validates :category, uniqueness: { scope: [:film_id, :user_id] }

  enum category: %i[directing story cinematography sound acting]
end
