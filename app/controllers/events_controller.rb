class EventsController < ApplicationController
  def index
    @age = rand(100)
    @events = ["BugSmash", "Hackathon", "Kata Camp"]
  end
end
