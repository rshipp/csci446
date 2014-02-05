class Pet < ActiveRecord::Base
  has_one :line_item
  before_destroy :ensure_not_referenced_by_any_line_item

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  validates :name, :breed, :image_url, :notes, :presence => true
  validates :age, :numericality => {:greater_than_or_equal_to => 1}
  validates :name, :uniqueness => true
  validates :image_url, :format => {
    :with    => %r{\.(gif|jpg|png)\z}i,
    :message => 'must be a URL for GIF, JPG, or PNG image.'
  }
end
