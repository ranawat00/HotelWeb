require 'rails_helper'
RSpec.describe Api::V1::AddressController, type: :controller do
  before do
    Categories.delete_all
    User.delete_all
    Address.delete_all
    @user = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password:'password',
            password_confirmation: 'password',avatar:Faker::LoremFlicker.image)
    @category = Category.create!(name:Faker::Lorem.word)
    @property = Property.create!(name:Faker::Lorem.word, description: Faker::Lorem.sentence, no_bedroom:2,
                no_baths:2, no_beds:2, area: 100.0, user:@user ,category:@category)
  end

  describe 'POST #create' do
    context'with valid parameters'do
      it'creates a new address and returns the address in JSON format'do
       post :create,params:
       {
        address:{
          city:'Noida',
          state:'UP',
          street:'H-96',
          house_number:'145',
          country:'India',
          Zip_code:'201301',
          property_id: @property.id
        }
       }
       expect(response).to have_http_status(:created)
       expect(response.content_type).to eq('application/json; charset=utf-8')
       except(response.body).to include('house_number')
       except(response.body).to include('street')
       except(response.body).to include('city')
       except(response.body).to include('state')
       except(response.body).to include('country')
       except(response.body).to include('zip_code')
       except(response.body).to include('property_id')
      end
    end

    context'with invalid parameters'do
      it'returns the errors in JSON format'
        post :create,params:{
          address:{
            city:'',
            house_number:'',
            state:'',
            street:'',
            country:'',
            Zip_code:'',
            property_id: ''
          }
        }
        except(response).to have_http_status(:unprocessable_entity)
        except(response.content_type).to eq('application/json; charset=utf-8')
        except(JSON.parse(response.body)).to eq({
          "city"=>["can't be blank"],
          "house_number"=>["can't be blank"],
          "state"=>["can't be blank"],
          "street"=>["can't be blank"],
          "country"=>["can't be blank"],
          "zip_code"=>["can't be blank"],
          "property_id"=>["must exist"]
        })
      end
    end

    describe 'PATCH #update' do
      before do
        @property=Property.create(name: 'My property', description:'This is my property',no_bedrooms:3
                              no_baths:3, no_beds:3, area:200,user:@user,category:@category)
        @address=Address.create(
          city:'Noida',
          state:'UP',
          street:'H-96',
          house_number:'145',
          country:'India',
          Zip_code:'201301',
          property_id: @property.id
        )
      end

      context'with valid parameters'do
        it'updates the address and returns the address in JSON format'do
          patch :update,params:{
            id: @address.id,
            address:{
              city:'Noida',
              state:'Uk',
              street:'H-97',
              house_number:'465',
              country:'India',
              Zip_code:'201302'
            }
          }
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json; charset=utf-
          8')
          except(response.body).to include(
            'id' =>@address.id
            'city'=> 'Noida',
            'state'=> 'Uk',
            'street'=> 'H-97',
            'house_number'=>'465',
            'country'=>'India',
            'Zip_code'=>'201302',
            'property_id'=>'@property_id'
          )
        end
      end
    end
  end
end



       

       


