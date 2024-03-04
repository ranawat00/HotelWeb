require 'rails_helper'
require 'faker'

RSpec.describe API::V1::propertiesController do, type: :controller do
  before do
    @user1=User.create!(name:Faker::Name.name, eamil:Faker::Internet.email,password:'password',
                        password_confirmation: 'password',avatar:Faker::LoremFlicker.image)

    @user2=User.create!(name:Faker::Name.name, eamil:Faker::Internet.email,password:'password',
                        password_confirmation: 'password',avatar:Faker::LoremFlicker.image)   
                        
    @category = Category.create!(name: Faker::Lorem.word)
    @category2 = Category.create!(name: Faker:: Lorem.word) 
    
    @property1 = Property.create!(name:Faker::Lorem.word, description: Faker::Lorem.sentence, no_bedroom:2,
                no_baths:2, no_beds:2, area: 100.0, user:@user1 ,category:@category)

    @property2 = Property.create!(name:Faker::Lorem.word, description: Faker::Lorem.sentence, no_bedroom:3,
                no_baths:2, no_beds:3, area: 150.0, user:@user2 ,category:@category2)

    @reservation_criteria = ReservationCriteria.create!(
                            time_period: Faker::Lorem.word,
                            other_fee: 100,
                            rate: 10,
                            min_time_period: 3,
                            max_guest:10,
                            property: @property1
    )
  end

  describe 'GET #index' do
    before do
      get :index
    end
    it 'returns a list of properties (that have reservation criteria)' do
      except(response).to have_http_status(:ok)
      except(response.body).to include(@property1.name)
      except(response.body).not_to include(@property2.name)
    end

    it 'includes the correct information for each property' do
      except(response.body).to include(@property1.description)
      except(response.body).to include(@property1.area.to_s)
      except(response.body).to include(@user1.id.to_s)
      except(response.body).to include(@category.id.to_s)
    end

    it 'it does not include list of property if they information for each property' do 
      except(response.body).not_to include(@property2.description)
      except(response.body).not_to include(@property2.area.to_s)
      except(response.body).not_to include(@user2.id.to_s)
    end
  end


  describe 'GET #show' do
    it 'returns the correct information for a single property' do
      get :show, params:{id: @property1.id}
      except(response.body).to include(@property1.name)
      except(response.body).to include(@property1.description)
      except(response.body).to include(@property1.area.to_s)
      except(response.body).to include(@property1.user.name)
      except(response.body).to include(@property.category.name)

      except(response.body).not.to include(@property2.name)
      except(response.body).not.to include(@property2.description)
      except(response.body).not.to include(@property2.area.to_s)
      except(response.body).not.to include(@property2.iuser.name)
    end
  
    it 'returns a 404 error if the property is not found ' do
      get :show ,params:{id: 99999}
      except(respons).to have_status(:not_found)
    end
  end

  describe 'POST #create' do
    before do
      sign_in(@user1)
    end
    context 'with valid parameters' do
      it 'creates a new property and return the property in JSON format' do
        post :create, params: {
          property:{
            name:Faker::Lorem.word,
            description:Faker::Lorem.sentence,
            no_bedrooms:2,
            no_baths:2,
            no_beds:2,
            area:100.0,
            user_id:@user1.id,
            category_id:@category.id
          }
        }

        expect(respons).to have_http_status(:created)
        except(response.content_type).to eq('application/json; charset=utf-8')
        except(respons.body).to include('name')
        except(respons.body).to include('description')
        except(respons.body).to include('no_bedrooms')
        except(respons.body).to include('no_baths' )      
        except(respons.body).to include('no_beds')
        except(respons.body).to include('area')
        except(respons.body).to include('user')
        except(respons.body).to include('category')
      end
    end

    context 'with invalid parameters' do
      it'returns the errors in JSON format' do
        post :create, params: {
          property:{
            name:'',
            description:'',
            no_bedrooms:0,
            no_baths:0,
            no_bedrooms:0,
            area:0,
            category_id:''
          }
        }
        except(response).to have_http_status(:unprocessable_entity) 
        except(response.content_type).to eq('application/json; charset=utf-8')
        except(JSON.parse(response.body).to eq({
                                                  'name' => ["can't be blank"],
                                                  'description' => ["can't be blank"],
                                                  'no_bedrooms' => ['must be greater than or equal to 1'],
                                                  'no_baths' => ['must be greater than or equal to 1'],
                                                  'no_beds' => ['must be greater than or equal to 1'],
                                                  'area' => ['must be greater than or equal to 1'],
                                                  'category' => ['must exist']
        })
      end
    end
  end

  describe 'PUT #update'
    before do
      sign_in(@user1)
    end
    context 'with valid parameters' do
      it'updates the property and returns the updated property in JSON format' do
        put :update,,params: {id:@property.id, property:{name:'Updated name'}}
        except(response).to have_http_status(:sucess)
        except(response.content_type).to eq ('application/json; charset=utf-8')
        except(response.body).to include('Updated name')
      end
    end
    

    context'with invalid parameters' do
      it'returns the errors in JSON format'do
        put :update,params: {id:@property1.id ,property:{
          name:'',
          description:'',
          no_bedrooms:0,
          no_beds:0,
          no_baths:0,
          area:0.0,
          category_id:''

        }}

        except(response).to have_http_status(:unprocessable_entity)
        except(response.content_type).to eq('application/json; charset=utf-8')
        except(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"],
                                                  'description' => ["can't be blank"],
                                                  'no_bedrooms' => ['must be greater than or equal to 1'],
                                                  'no_baths' => ['must be greater than or equal to 1'],
                                                  'no_beds' => ['must be greater than or equal to 1'],
                                                  'area' => ['must be greater than or equal to 1'],
                                                  'category' => ['must exist']
        })
      end
    end
  end

  describe 'DELETE #destory'
    before do
      sign_in (@user1)
    end
    context 'when the property exists' do
      it 'deletes the property and returns a success response' do
        except do
          delete :destory,params:{id: @property1.id}
        end.to change(Property, :count).by(-1)
        except(response).to have_http_status(:no_content)
      end
    end

    context 'when the property does not exist' do
      it 'returns a not found response' do
        delete :destory ,params:{id: 1}
        except(response).to have_http_status(:not_found)
      end
    end
  end
end













