class Folder < ApplicationRecord

  LEVELS = {
    ROOT: "__root__",
    SUBFOLDER: "__subfolder__"
  }

  belongs_to :user
  belongs_to :parent_folder, polymorphic: true, optional: true
  has_many :subfolders, class_name: :Folder, as: :parent_folder
  has_many :documents, as: :parent_folder

  validates :level, {
    uniqueness: {
      scope: :user,
      message: "User already has a root folder"
    }
  }

  validate :has_parent_unless_root
  validate :root_has_no_parent

  private def has_parent_unless_root
    unless level == Folder::LEVELS[:ROOT] || parent_folder
      errors.add(:parent_folder, 'is required for non-root folders')
    end
  end

  private def root_has_no_parent
    if level == Folder::LEVELS[:ROOT] && parent_folder
      errors.add(:parent_folder, 'cannot be added to a root folder')
    end
  end

end