class Album < ActiveRecord::Base
  has_and_belongs_to_many :songs

  # Validations
  validates :name, :year, presence: true
  validates :name, uniqueness: true
end
