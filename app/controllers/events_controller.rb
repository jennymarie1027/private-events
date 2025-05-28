class EventsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
  
    def index
      @events = Event.all
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      @event.creator = current_user

      if @event.save
        redirect_to events_path, notice: 'Event was successfully created'
      else
        flash.now[:alert] = 'Event could not be created'
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @event = Event.find(params[:id])
      @creator = @event.creator
    end

    def edit
      @event = Event.find(params[:id])
      unless @event.creator == current_user
        redirect_to events_path, alert: 'You are not authorized to edit this event'
      end
    end

    def update
      @event = Event.find(params[:id])
      if @event.update(event_params)
        redirect_to event_path(@event), notice: 'Event was successfully updated'
      else
        flash.now[:alert] = 'Event could not be updated'
        render :edit, status: :unprocessable_entity
      end
    end

    def delete
      @event = Event.find(params[:id])
    end

    def destroy
      @event = Event.find(params[:id])
      puts "Deleting event: #{@event.inspect}"
      @event.destroy
      redirect_to events_path, notice: 'Event was successfully deleted'
    end

    private
    def event_params
      params.require(:event).permit(:title, :description, :location, :time)
    end
end

# @events = @user.events
# @user = User.find(params[:user_id])
# @event = @user.events.build(title: 'New Event', description: 'Event Description')