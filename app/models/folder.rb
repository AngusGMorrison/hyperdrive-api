class Folder < ApplicationRecord

  belongs_to :containing_folder, polymorphic: true
  has_many :subfolders, class_name: :Folder, as: :containing_folder
  has_many :documents, as: :containing_folder

end