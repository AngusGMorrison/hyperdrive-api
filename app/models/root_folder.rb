class RootFolder < ApplicationRecord

  belongs_to :user
  has_many :subfolders, class_name: :Folder, foreign_key: :containing_folder_id
  has_many :documents, as: :containing_folder

end