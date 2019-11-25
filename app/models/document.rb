class Document < ApplicationRecord
  belongs_to :folder
  belongs_to :user, through: :folder

  has_one_attached :file_data
  
end
