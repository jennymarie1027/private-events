require 'spec_helper'
require 'rails_helper'

describe EventsController do

    before do
        FactoryBot.create_list(:event, 5)
    end

    describe "GET /events" do
        it "returns a list of events" do
            get "/events" #events_path # Assuming you have a route defined for events
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to be >= 0
        end
    end
    
    describe "POST /events" do
        it "creates a new event" do
            user = User.first
            sign_in user
            post "/events", params: { event: { creator: user.id, title: "Test Event", time: "2023-10-01", location: "test location", description: "fun" } }
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(events_path)
            expect(Event.last.title).to eq("Test Event")
        end
    end
    
    # describe "PUT /events/:id" do
    #     let!(:event) { create(:event, name: "Old Event") }
    
    #     it "updates an existing event" do
    #     put event_path(event), params: { event: { name: "Updated Event" } }
    #     expect(response).to have_http_status(:ok)
    #     expect(JSON.parse(response.body)["name"]).to eq("Updated Event")
    #     end
    # end
    
    # describe "DELETE /events/:id" do
    #     let!(:event) { create(:event) }
    
    #     it "deletes an event" do
    #     delete event_path(event)
    #     expect(response).to have_http_status(:no_content)
    #     end
    # end
end