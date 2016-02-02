require 'rails_helper'

RSpec.describe "Profiles API" do
  describe "GET/me" do
    context "unauthorized" do
      it 'returns 401 status if request has not access token' do
        get '/api/v1/profiles/me', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access token is invalid' do
        get '/api/v1/profiles/me', format: :json, access_token: '12345'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it 'contains email' do
        expect(response.body).to be_json_eql(me.email.to_json).at_path('email')
      end
    end
  end
end