Rails.application.routes.draw do
  root "events#index"

  resources :events # Rails makes all routes for event with one line

  # get "events" => "events#index"
  # post "events/new" => "events#create"
  # get "events/:id" => "events#show", as: "event"
  # get "events/:id/edit" => "events#edit", as: "edit_event"
  # patch "events/:id" => "events#update"

end
