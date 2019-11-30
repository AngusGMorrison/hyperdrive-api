Rails.application.routes.draw do
  post "/sign-up", to: "users#sign_up"
  post "/sign-in", to: "users#sign_in"

  get "/drive/folders/:folder_id", to: "drive#show_folder"
  post "/drive/folders/:folder_id", to: "drive#create_document"
  get "/drive", to: "drive#show_root"

  delete "/drive/:document_id", to: "drive#delete_document"
  get "/drive/:document_id", to: "drive#download_document"
end
