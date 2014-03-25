require 'test_helper'

class PetTest < ActiveSupport::TestCase
  fixtures :pets

  test "pet attributes must not be empty" do
    pet = Pet.new
    assert pet.invalid?
    assert pet.errors[:name].any?
    assert pet.errors[:breed].any?
    assert pet.errors[:image_url].any?
    assert pet.errors[:notes].any?
  end

  test "pet age must be positive" do
    pet = Pet.new(:name => 'one',
                  :breed => 'two',
                  :image_url => 'a.png',
                  :shots => true,
                  :notes => 'some',
                  :status => 'Available')
    pet.age = -1
    assert pet.invalid?
    assert_equal "must be greater than or equal to 1", pet.errors[:age].join('; ')

    pet.age = 0
    assert pet.invalid?
    assert_equal "must be greater than or equal to 1", pet.errors[:age].join('; ')

    pet.age = 1
    assert pet.valid?
  end

  def new_pet(image_url)
    Pet.new(:name => 'one',
            :breed => 'two',
            :image_url => image_url,
            :age => 1,
            :shots => true,
            :notes => 'some',
            :status => 'Available')
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_pet(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_pet(name).invalid?, "#{name} shouldn't be valid"
    end
  end
end
