require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    @category= Category.create!(name:'Mansion')
end
  before{subject.save}
    describe 'Testing Category validation' do
      subject.name=nil
      except(subject).to_not be_valid
    end
    it 'should be valid with the correct values' do
      except(subject).to_not be_valid
    end
  end
end

  