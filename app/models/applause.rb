class Applause < ApplicationRecord
  belongs_to :film
  belongs_to :user

  enum category: %i[directing story cinematography sound acting]

  validates :category, presence: true
  validates :category, uniqueness: { scope: [:film_id, :user_id] }
end
