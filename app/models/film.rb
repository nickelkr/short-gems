class Film < ApplicationRecord
  belongs_to :user
  has_many :applauses, dependent: :destroy

  validates :external_id, uniqueness: true
  validates :runtime, numericality: { greater_than: 0,
                                      less_than_or_equal_to: 50,
                                      only_integer: true ,
                                      message: 'Runtime can only be whole numbers between 0 and 50 minutes.'}
end
