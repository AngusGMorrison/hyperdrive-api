Rails.application.routes.draw do
  post "/sign-up", to: "users#sign_up"
  post "/sign-in", to: "users#sign_in"

  get "/drive/folders/:id", to: "drive#show_folder"
  post "/drive/folders/:id", to: "drive#create_document"
  delete "/drive/folders/:id", to: "drive#delete_folder"
  post "/drive/folders/", to: "drive#create_folder"

  get "/drive/documents/:id", to: "drive#download_document"
  delete "/drive/documents/:id", to: "drive#delete_document"

  get "/drive", to: "drive#show_root"
end
