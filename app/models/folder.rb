class Folder < ApplicationRecord

  ROOT = {
    level: "__root__",
    name: "My Hyperdrive"
  }

  belongs_to :user
  belongs_to :parent_folder, polymorphic: true, optional: true
  has_many :subfolders, class_name: :Folder, as: :parent_folder
  has_many :documents, as: :parent_folder, dependent: :destroy

  validates :name, length: { in: 1..50 }
  validate :root_folder_is_unique_and_immutable
  validate :has_parent_unless_root
  validate :root_has_no_parent
  validate :not_own_parent

  private def root_folder_is_unique_and_immutable
    if level == ROOT[:level] && user.root_folder 
      errors.add(:level, "Root folder cannot be modified")
    end
  end

  private def has_parent_unless_root
    unless level == ROOT[:level] || parent_folder
      errors.add(:parent_folder, 'is required for non-root folders')
    end
  end

  private def root_has_no_parent
    if level == ROOT[:level] && parent_folder
      errors.add(:parent_folder, 'cannot be added to a root folder')
    end
  end

  private def not_own_parent
    if self == parent_folder
      errors.add(:parent_folder, 'must be different to current folder')
    end
  end

  private def self.destroy_subfolder(folder)
    raise DriveError::RootDeletion if folder.level == ROOT[:level]
    folder.destroy
  end

  private def self.move_subfolder(folder_to_move, destination_folder)
    raise DriveError::RootMove if folder.level == ROOT[:level]
    folder_to_move.update(parent_folder: destination_folder)
  end

end