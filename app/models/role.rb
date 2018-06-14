class Role < ApplicationRecord
  belongs_to :user

  def self.admin?
    where(role_type: 'admin', active: true)
    .first
    .present?
  end
end
