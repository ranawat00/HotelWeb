require 'rails_helper'

RSpec.describe Property, type: :model do
  let (:category){Category.create(name: 'Apartment')}
  let(:user){User.create(name:'Gaurav',email:'gauravranwat7900@gmail.com',password:'password',role:'user',avatar:'https://randomuser.me/api/portraits/men/1.jpg')}

  before do
    @property=Property.new(
      name:'view Apartment',
      description:'view Apartment in the heart of the dehradoon',
      no_beds:2,
      no_baths:2,
      no_bedrooms:1,
      area:50.0,
      user:'User',
      category:

    )
  end

  it 'is valid with valid attributes' do
    except(@property).to be_valid
  end

  it 'is not valid without a name' do
    @property.name = nil
    expect(@property).to_not be_valid
  end

  it 'is not valid without a description' do
    @property.description = nil
    expect(@property).to_not be_valid
  end

  it 'is not valid without a user' do
    @property.user = nil
    expect(@property).to_not be_valid
  end

  it 'is not valid without a category' do
    @property.category = nil
    expect(@property).to_not be_valid
  end
end


