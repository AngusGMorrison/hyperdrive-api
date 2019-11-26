class User < ApplicationRecord

  has_secure_password

  has_many :folders
  has_many :documents

  after_create :create_root_folder

  private def create_root_folder
    Folder.create(user_id: self.id, name: Folder::ROOT)
  end

  def root_folder
    self.folders.root
  end

  def capitalized_name
    self.name.capitalize
  end

  def bytes_stored
    self.documents.sum { |document| document.byte_size }
  end

  def remaining_storage
    self.storage_allowance - self.bytes_stored
  end

  def has_enough_storage?(bytes)
    bytes <= self.remaining_storage
  end

  validates :name, :email, :password, {
    presence: true
  }

  validates :name, {
    format: {
      with: ValidationRegexps::NAME,
      message: "must be 2-50 chars (only letters, spaces, - and ')."
    }
  }

  validates :email, {
    uniqueness: {
      message: 409
    },
    format: {
      with: URI::MailTo::EMAIL_REGEXP,
      message: "is invalid."
    }
  }

  validates :password, {
    format: {
      with: ValidationRegexps::PASSWORD,
      message: "needs min. 8 chars: 1 number, 1 upper, 1 lower, 1 special."
    }
  }

end