class Folder < ApplicationRecord

  belongs_to :user
  has_many :subfolders, class_name: :Folder, foreign_key: :containing_folder
  has_many :documents, as: :containing_folder

end