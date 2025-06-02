require 'spec_helper'
require 'rails_helper'

describe "Events API", type: :request do
    describe "as an authorized user" do

        describe "GET /events" do
            let!(:events) { FactoryBot.create_list(:event, 5) }
            it "returns a list of events" do
                get events_path
                expect(response).to have_http_status(:ok)
                expect(JSON.parse(response.body).size).to eq(5)
            end
        end
        
        describe "POST /events" do
            let(:user) { FactoryBot.create(:user) }
            it "creates a new event" do
                sign_in user
                post events_path, params: { event: { creator: user.id, title: "Test Event", time: "2023-10-01", location: "test location", description: "fun" } }
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(events_path)
                expect(Event.last.title).to eq("Test Event")
            end
        end
        
        describe "PUT /events/:id" do
            let(:user) { FactoryBot.create(:user) }
            let(:event) { FactoryBot.create(:event, creator: user, title: "Original Title") }
            
            it "updates an existing event" do
                sign_in user
                patch event_path(event), params: { event: { title: "Updated Title" } } 
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(event_path(event))
                event.reload
                expect(event.title).to eq("Updated Title")
            end
        end
        
        describe "DELETE /events/:id" do
            let(:user) { FactoryBot.create(:user) }
            let(:event) { FactoryBot.create(:event, creator: user, title: "Original Title") }
        
            it "deletes an event" do
                sign_in user
                delete event_path(event)
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(events_path)
                expect(Event.find_by(id: event.id)).to be_nil
            end
        end

        describe "POST /events/:id/invite" do
            let(:user) { FactoryBot.create(:user) }
            let(:event) { FactoryBot.create(:event, creator: user) }
            let(:invitee) { FactoryBot.create(:user) }

            it "invites users to an event" do
                sign_in user
                post invite_event_path(event), params: { user_ids: [invitee.id] }
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(event_path(event))
                expect(event.attendees).to include(invitee)
            end

            it "does not invite users if no user_ids are provided" do
                sign_in user
                post invite_event_path(event), params: { user_ids: [] }
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(event_path(event))
                expect(event.attendees).to be_empty
            end
        end
    end
    describe "as an unauthorized user" do

        describe "GET /events" do
            before { FactoryBot.create_list(:event, 5) }
            it "returns a list of events" do
                get events_path
                expect(response).to have_http_status(:ok)
                puts response.body.size
                puts response.body

                expect(JSON.parse(response.body).size).to be >= 5
            end
        end
        
        describe "POST /events" do
            it "redirects to user login page" do
                post events_path, params: { event: { title: "Unauthorized Event", time: "2023-10-01", location: "test location", description: "fun" } }
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(new_user_session_path)
            end
        end
        
        describe "PUT /events/:id" do
            let(:event) { FactoryBot.create(:event) }
            it "redirects to user login page" do
                patch event_path(event), params: { event: { title: "Updated Title" } }
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(new_user_session_path)
            end
        end
        
        describe "DELETE /events/:id" do
            let(:event) { FactoryBot.create(:event) }
            it "redirects to user login page" do
                delete event_path(event)
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        describe "POST /events/:id/invite" do
            let(:event) { FactoryBot.create(:event) }
            it "redirects to user login page" do
                post invite_event_path(event), params: { user_ids: [1, 2] }
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(new_user_session_path)
            end
        end
    end
end