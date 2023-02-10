class EventsController < ApplicationController
  def index
    @age = rand(100)
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])

  end

  def update
    @event = Event.find(params[:id])

    @event.update(event_params)

    redirect_to event_path
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save

    redirect_to event_path(@event)
  end

  private

  def event_params
    params.require(:event)
      .permit(:name, :description, :location, :price, :starts_at)
  end
end
