Rails.application.routes.draw do
  get "/sign-up", to: "users#sign_up"
end
