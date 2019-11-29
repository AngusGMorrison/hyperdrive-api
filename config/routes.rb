Rails.application.routes.draw do
  post "/sign-up", to: "users#sign_up"
  post "/sign-in", to: "users#sign_in"

  get "/drive/folders/:folder_id", to: "drive#show_folder"
  get "/drive", to: "drive#show_root"
  post "/drive", to: "drive#create"

  delete "/drive/:document_id", to: "drive#delete_document"
  get "/drive/:document_id", to: "drive#download_document"
end
