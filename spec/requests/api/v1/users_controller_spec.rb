require 'rails_helper'

RSpec.describe 'Api::V1::UsersControllers', type: :request do

  describe "GET#index" do
    context 'when users present' do 
      let!(:user1) { FactoryBot.create(:user, name: 'user1') }
      let!(:user2) { FactoryBot.create(:user, name: 'user2') }
      it 'return status 200' do 
        get '/api/v1/users'
        expect(response).to have_http_status(:ok)
      end

      it 'All users data' do 
        get '/api/v1/users'

        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(2)
        expect(json_response[0]['name']).to eq(user1.name)
        expect(json_response[0]['email']).to eq(user1.email)
        expect(json_response[1]['name']).to eq(user2.name)
        expect(json_response[1]['email']).to eq(user2.email)
      end
    end

    context 'when users not present' do
      it 'return status not valid ' do
        get '/api/v1/users'

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('No users found')
      end 
    end
  end


  describe "GET#show" do
    context 'when user present' do
      let!(:user1) { FactoryBot.create(:user, name: 'user1') }
      let!(:user2) { FactoryBot.create(:user, name: 'user2') }
      it 'returns status 200' do 
        get "/api/v1/users",params: {id:user1.id}
        expect(response).to have_http_status(:ok)
      end 

      it 'returns status 200' do
        get '/api/v1/users', params: { id: user1.id}

        json_response = JSON.parse(response.body)
        expect(json_response[0]["name"]).to eq(user1.name)
        expect(json_response[0]["email"]).to eq(user1.email)
        expect(json_response[0]["id"]).to eq(user1.id)
      end 
    end 

    context 'when user not present' do
      it 'returns status not found' do
        get '/api/v1/users', params: { id: 2}
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:not_found)
        expect(json_response["error"]).to eq("No users found")
      end
    end
  end



  describe "PATCH#update" do
    context 'when users present' do 
      let!(:user1) { FactoryBot.create(:user, name: 'user1') }
      let!(:user2) { FactoryBot.create(:user, name: 'user2') }
      it 'return status 200' do 
        patch '/api/v1/users'
        expect(response).to have_http_status(:ok)
      end
      it 'update user data' do
        patch '/api/v1/users', params: { id: user1.id, name: 'new_name', email: 'new_email' }

        json_response = JSON.parse(response.body)
        expect(json_response[0]["name"]).to eq(user1.new_name)
        expect(json_response[0]["email"]).to eq(user1.new_email)
        expect(json_response[0]["id"]).to eq(user1.id)
      end
    end

    context 'when users not present' do
      it'return status not found' do
        
        patch '/api/v1/users', params: { id: 2}
        json_response =JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(json_response["error"]).to eq("Validation failed")
      end
    end
  end



  describe"DEL#destroy" do
    context 'when users present' do
      let!(:user1) { FactoryBot.create(:user, name: 'user1') }
      let!(:user2) { FactoryBot.create(:user, name: 'user2') }
      it'return status 200' do
        delete '/api/v1/users', params: { id: user1.id }
        expect(response).to have_http_status(:ok)
      end
      
      it'delete user data' do
        delete '/api/v1/users', params: { id: user1.id }

        json_response = JSON.parse(response.body)
        expect(json_response[0]["name"]).to eq(user1.name)
        expect(json_response[0]["email"]).to eq(user1.email)
        expect(json_response[0]["id"]).to eq(user1.id)
      end
    end
    context 'when users not present' do
      it'return status not found' do

        delete '/api/v1/users', params: { id: 2}
        json_response =JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(json_response["error"]).to eq("User not deleted")
      end
    end
  end
end