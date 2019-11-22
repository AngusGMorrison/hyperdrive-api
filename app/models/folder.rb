class Folder < ApplicationRecord
  scope :root, -> { where("name = '__root__'")}

  belongs_to :user
end
