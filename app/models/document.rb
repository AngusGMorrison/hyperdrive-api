class Document < ApplicationRecord
  belongs_to :folder

  has_one_attached :file_data

end
