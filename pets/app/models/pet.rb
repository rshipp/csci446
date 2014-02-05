class Pet < ActiveRecord::Base
  validates :name, :breed, :image_url, :notes, :presence => true
  validates :age, :numericality => {:greater_than_or_equal_to => 1}
  validates :name, :uniqueness => true
  validates :image_url, :format => {
    :with    => %r{\.(gif|jpg|png)\z}i,
    :message => 'must be a URL for GIF, JPG, or PNG image.'
  }
end
