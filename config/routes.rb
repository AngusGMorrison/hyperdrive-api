Rails.application.routes.draw do
  post "/sign-up", to: "users#sign_up"
  post "/sign-in", to: "users#sign_in"

  get "/drive/folders/:id", to: "folders#show"
  get "/drive/folders", to: "folders#show"
  post "/drive/folders", to: "folders#create"
  patch "/drive/folders/:id", to: "folders#move"
  delete "/drive/folders/:id", to: "folders#destroy"

  get "/drive/documents/:id", to: "documents#download"
  post "/drive/documents/", to: "documents#create"
  patch "/drive/documents/:id", to: "documents#move"
  delete "/drive/documents/:id", to: "documents#destroy"
end
