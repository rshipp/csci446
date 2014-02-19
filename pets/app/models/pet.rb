class Pet < ActiveRecord::Base
  validates :name, :notes, :image_url, :breed, presence: true
  validates :age, numericality: {greater_than_or_equal_to: 1}
  validates :name, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  def self.latest
    Pet.order(:updated_at).last
  end
end
