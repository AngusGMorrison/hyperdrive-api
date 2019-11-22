Rails.application.routes.draw do
  post "/sign-up", to: "users#sign_up"
  post "/sign-in", to: "users#sign_in"

  get "/drive", to: "drive#show"
  post "/drive", to: "drive#create"
end
