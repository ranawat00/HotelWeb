require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    User.delete_all
end

  descirbe 'validations' do
    it 'is not valid without an email' do
      user =User.create(name: 'Gaurav', password:'password' ,avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      except(user).not_to be_valid
    end

    it 'is valid without a name' do
      user =User.create(email:'gauravrannawat7900@gmail.com', password:'password' avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      expect(user).to be_valid
    end

    it 'is not valid with a duplicate email' do
      user = create(name:'Gaurav', email: 'gauravranawat7900@gmail.com', password:'password' avatar:'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email format' do
      user =User.create(name:'Gaurav',email: 'gauravranawat7900@gmail.com', password:'password', avatar:'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user =User.create(name:'Gaurav',email: 'gauravranawat7900@gmail', avatar:'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      except(user).not_to be_valid
    end

    it 'is not valid without an avatar' do
      user =User.create(name:'Gaurav',email: 'gauravranawat7900@gmail', password:'password', avatar:'')
      except(user).not_to be_valid
    end

    it  "is not valid without a role of  'other' " do
      user=User.create(name:'Gaurav',email: 'gauravranawat7900@gmail', password:'password', role:'other', avatar:'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      except(user).not_to be_valid
    end

    it "it is valid  with a role of 'user' "do
      user=User.create(name:'Gaurav', email:'gauravranawat7900@gmail.com', password: 'password', role: 'user',avatar:'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      except(user.role).to eq('user')
   end

   it "is valid with a role of 'admin'" do
     user=User.create(name:'Gaurav', email:'gauravranawat7900@gmail.com', password: 'password', role: 'admin',avatar:'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
     except(user.role).to eq('admin')
   end

   it "is valid with valid attributes" do
    user = User.create(name: 'Gaurav', email: 'gauravranawat7900@gmail.com',password: 'password', password_confirmation: 'password',role: 'admin',avatar:'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
    except (user).to be be_valid
   end
  end

  descirbe 'defaults' do
    user = User.create(name:'Gaurav', email: 'gauravranawat7900@gmail.com',password: 'password',password_confirmation: 'password',avatar:'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

    it "has a default role of 'user' " do
      expect(user.role).to eq('user')
      except(user).to be_valid
    end
  end
end

