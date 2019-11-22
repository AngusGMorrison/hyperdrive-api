class Folder < ApplicationRecord

  ROOT_NAME = '__root__'
  scope :root, -> { where(name: ROOT_NAME)}

  belongs_to :user
  has_many_attached :files

end