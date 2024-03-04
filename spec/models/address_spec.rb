require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:category){Category.create(name:'Apartment')}
  let(:user){(User.create(name:'Gaurav',email:'gauravranawat7900@gmail.com',password:'password',role:'user',avatar:'https://randomuser.me/api/portraits/men/1.jpg'))}

end
  before do
    @property=Property.new(
      name:'Hill Apartment',
      description:'Hill Apartment in the heart of the dehradoon city',
      no_bedrooms: 1,
      no_baths: 1,
      no_beds:2
      area:50.0,
      user: 'User',
      category:
    )
    @address=Address.new(
      city:'Noida',
      state:'U.P',
      street:'electronic city'
      country:'India',
      zip_code:'123',
      house_number:'503'
      property: @property
    )
  end

  context 'when all attributes are present' do
    it'is valid' do
      expect(@address).to be_valid
    end
  end

  context 'when the country is not present' do
    it'is not valid' do
      @address.country=nil
      expect(@address).to_not be_valid
    end
  end

  context 'when the zip_code is not present' do
    it'is not valid' do
      @address.zip_code=nil
      expect(@address).to_not be_valid
    end
  end

  context 'when  the street is not present ' do
    it'is not valid' do
      @address.street=nil
      expect(@address).to_not be_valid
    end
  end

  context 'when the house_number is not present' do
    it'is not valid' do
      @address.house_number=nil
      expect(@address).to_not be_valid
    end
  end

  context 'when the city is not present' do
    it'is not valid' do
      @address.city=nil
      expect(@address).to_not be_valid
    end
  end
  context 'when the state is not present' do
    it'is not valid' do
      @address.state=nil
      expect(@address).to_not be_valid
    end
  end

  context 'when the property is not present' do
    it'is not valid' do
      @address.property=nil
      expect(@address).to_not be_valid
    end
  end
  
