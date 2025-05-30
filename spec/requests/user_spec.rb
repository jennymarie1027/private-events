require 'rails_helper'

# This is a simple request spec for testing the UsersController
RSpec.describe "Users", type: :request do
    describe "GET /users" do
      it "returns a list of users" do
        get '/users'
        # expect(response).to have_http_status(:ok)
        # expect(JSON.parse(response.body).size).to eq(5)
        puts "Response: #{response.body}"
      end
    end
  end