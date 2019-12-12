class User < ApplicationRecord
  include Error, StorageCalculator

  has_secure_password

  has_many :documents
  has_many :folders

  after_create :create_root_folder

  private def create_root_folder
    Folder.create(user_id: self.id, level: Folder::ROOT[:level], name: Folder::ROOT[:name])
  end

  validates :name, :email, :password, {
    presence: true
  }

  validates :name, {
    format: {
      with: Validation::RegExps::NAME,
      message: Validation::Messages::NAME
    }
  }

  validates :email, {
    uniqueness: {
      message: 409
    },
    format: {
      with: URI::MailTo::EMAIL_REGEXP,
      message: Validation::Messages::EMAIL
    }
  }

  validates :password, {
    format: {
      with: Validation::RegExps::PASSWORD,
      message: Validation::Messages::PASSWORD
    }
  }

  def root_folder
    self.folders.find_by!(level: Folder::ROOT[:level])
  rescue ActiveRecord::RecordNotFound
    raise MissingRootFolder
  end

  def find_owned(model_name, id)
    class_name = model_name.to_s.classify.constantize
    class_name.find_by!(id: id, user: self)
  rescue ActiveRecord::RecordNotFound
    raise OwnedObjectNotFound(class_name)
  end

end