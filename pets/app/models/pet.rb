class Pet < ActiveRecord::Base
  has_many :pet_items
  has_one :foster_pet
  
  STATUS_OPTIONS = [ "Available", "Fostered" ]

  before_destroy :ensure_not_referenced_by_any_pet_item
  #before_destroy :ensure_not_referenced_by_any_foster_pet

  private

  def ensure_not_referenced_by_any_pet_item
    if pet_items.empty?
      return true
    else
      errors.add(:base, 'Pet Items present')
      return false
    end
  end

  validates :name, :notes, :image_url, :breed, presence: true
  validates :age, numericality: {greater_than_or_equal_to: 1}
  validates :name, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :status, allow_blank: false, format: {
    with: /\A(Available|Fostered)\Z/,
    message: 'must be "Available" or "Fostered".'
  }

  def self.latest
    Pet.order(:updated_at).last
  end
end
