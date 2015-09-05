class Song < ActiveRecord::Base
  has_and_belongs_to_many :albums

  # Validations
  validates :title, :lyrics, presence: true, uniqueness: true
end
