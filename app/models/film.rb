class Film < ApplicationRecord
  belongs_to :user

  validates :external_id, uniqueness: true
  
  before_validation :extract_id

  private
    def extract_id
      if /\/watch\?v=/ =~ external_id
        self.external_id = external_id.split('=').last
      else
        self.external_id = external_id.split('/').last
      end
    end
end
