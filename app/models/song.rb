class Song < ActiveRecord::Base
  has_and_belongs_to_many :albums

  # Validations
  validates :title, :lyrics, presence: true, uniqueness: true

  # Methods
  def self.search(query)
    where("lyrics like ?", "%#{query}%")
  end
end
