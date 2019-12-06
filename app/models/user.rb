class User < ApplicationRecord

  has_secure_password

  has_many :documents
  has_many :folders

  after_create :create_root_folder

  private def create_root_folder
    Folder.create(user_id: self.id, level: Folder::LEVELS[:ROOT], name: Folder::ROOT_NAME)
  end

  def root_folder
    self.folders.find_by(level: Folder::LEVELS[:ROOT])
  end

  def capitalized_name
    name_array = self.name.split(" ")
    name_array.map(&:capitalize).join(" ")
  end

  def storage_used_in_bytes
    self.documents.sum { |document| document.byte_size }
  end

  def remaining_storage_in_bytes
    self.storage_allowance - self.storage_used_in_bytes
  end

  def has_enough_storage?(bytes)
    bytes <= self.remaining_storage
  end

  protected def find_owned_folder(id)
    Folder.find_by!(id: id, user: self)
  rescue ActiveRecord::RecordNotFound
    raise DriveError::FolderNotFound

  end

  protected def find_owned_document(id)
    Document.find_by!(id: id, user: self)
  rescue ActiveRecord::RecordNotFound
    raise DriveError::DocumentNotFound
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