class EventsController < ApplicationController
  def index
    @age = rand(100)
    @events = Event.all
  end
end
