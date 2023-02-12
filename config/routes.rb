Rails.application.routes.draw do

  resources :users
  root "events#index"

  resources :events do # Rails makes all routes for event with one line
    resources :registrations #makes events/id/registrations
  end

  # get "events" => "events#index"
  # post "events/new" => "events#create"
  # get "events/:id" => "events#show", as: "event"
  # get "events/:id/edit" => "events#edit", as: "edit_event"
  # patch "events/:id" => "events#update"

end
