class Folder < ApplicationRecord

  ROOT = '__root__'
  scope :root, -> { find_by(name: ROOT)}

  belongs_to :user
  has_many :documents

end