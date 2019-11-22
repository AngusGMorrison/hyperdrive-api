class User < ApplicationRecord

  has_secure_password

  has_many :folders

  after_create :create_root_folder

  private def create_root_folder
    Folder.create(user_id: self.id, name: Folder::ROOT_NAME)
  end

  def root_folder
    self.folders.root
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
