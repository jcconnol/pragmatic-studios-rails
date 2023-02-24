class EventsController < ApplicationController

  before_action :require_sign_in, except: [:show, :index]
  before_action :require_admin, except: [:show, :index]

  def index
    @age = rand(100)
    case params[:filter]
    when "past"
      @events = Event.past
    when "free"
      @events = Event.free
    when "recent"
      @events = Event.recent
    else
      @events = Event.upcoming
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to events_url, alert: "Movie removed!"
    else
      render :edit
    end
  end

  def show
    @event = Event.find(params[:id])
    @likers = @event.likers
    if current_user
      @like = current_user.likes.find_by(event_id: @event.id)
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to event_path, notice: "Event updated!"
    else
      render :edit
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path(@event), notice: "Event created!"
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event)
      .permit(:name, :description, :location, :price, :starts_at, :capacity, :image_file_name)
  end
end
