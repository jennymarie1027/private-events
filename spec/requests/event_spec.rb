require 'spec_helper'
require 'rails_helper'

describe EventsController do

    before do
        FactoryBot.create_list(:event, 5)
    end

    describe "GET /events" do
        it "returns a list of events" do
            get events_path # Assuming you have a route defined for events
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to be >= 0
        end
    end
    
    describe "POST /events" do
        it "creates a new event" do
            user = User.first
            sign_in user
            post events_path, params: { event: { creator: user.id, title: "Test Event", time: "2023-10-01", location: "test location", description: "fun" } }
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(events_path)
            expect(Event.last.title).to eq("Test Event")
        end
    end
    
    describe "PUT /events/:id" do
        user = FactoryBot.create(:user)
        event = FactoryBot.create(:event, creator: user, title: "Original Title")
        # let!(:event) { create(:event, title: "Old Event") }
        
        it "updates an existing event" do
            # user = User.find(event.user_id)
            sign_in user
            patch "/events/#{event.id}", params: { event: { title: "Updated Title" } } 
            puts "Event === #{event.inspect}"
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(event_path(event))
            event.reload
            expect(event.title).to eq("Updated Title")
        end
    end
    
    # describe "DELETE /events/:id" do
    #     let!(:event) { create(:event) }
    
    #     it "deletes an event" do
    #     delete event_path(event)
    #     expect(response).to have_http_status(:no_content)
    #     end
    # end
end