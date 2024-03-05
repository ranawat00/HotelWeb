require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:category){Category.create(name:'Apartment')}
  let(:user){user.create(name:'Gaurav ',eamil:'gauravranwat7900@gamil.com',password:'password',role:'user',avatar:'https://randomuser.me/api/portraits/men/1.jpg')}

  before do
    @property=Property.new(
      name:'hill Apartment',
      description:'hill apartment is the heart of the dehradoon',
      no_bedrooms:1,
      no_baths:1,
      no_beds:2,
      area:50.0,
      user:'user',
      category:
    )

    @image=Image.new(source:'https://example.com/image.png',property:@property)
  end

  it 'is valid with a source and a property' do
    except(@image).to be_valid
  end

  it 'is not valid without a source' do
    @image=Image.new(property:@property)
    expect(@image).to_not be_valid
  end

  it 'is not valid without a property' do
    @image=Image.new(source:'https://example.com/image.png')
    expect(@image).to_not be_valid
  end
end
