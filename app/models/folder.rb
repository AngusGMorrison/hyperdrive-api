class Folder < ApplicationRecord

  ROOT = {
    level: "__root__",
    name: "My Hyperdrive"
  }.freeze

  belongs_to :user
  belongs_to :parent_folder, polymorphic: true, optional: true
  has_many :subfolders, class_name: :Folder, as: :parent_folder
  has_many :documents, as: :parent_folder, dependent: :destroy

  validates :name, length: { in: 1..50 }
  validate(
    :is_unique_and_immutable_if_root,
    :has_parent_unless_root,
    :has_no_parent_if_root,
    :is_not_own_parent
  )

  private def is_unique_and_immutable_if_root
    if level == ROOT[:level] && Folder.find_by(level: ROOT[:level], user: user)
      errors.add(:level, Validation::Messages::FOLDER[:immutable_root])
    end
  end

  private def has_parent_unless_root
    unless level == ROOT[:level] || parent_folder
      errors.add(:parent_folder, Validation::Messages::FOLDER[:parent_folder_required])
    end
  end

  private def has_no_parent_if_root
    if level == ROOT[:level] && parent_folder
      errors.add(:parent_folder, Validation::Messages::FOLDER[:root_has_parent])
    end
  end

  private def is_not_own_parent
    if self == parent_folder
      errors.add(:parent_folder, Validation::Messages::FOLDER[:own_parent])
    end
  end

  def self.move_subfolder(folder_to_move, destination_folder)
    raise RootFolderMove if folder_to_move.level == ROOT[:level]
    folder_to_move.update(parent_folder: destination_folder)
  end

  def self.destroy_subfolder(folder)
    raise RootFolderDeletion if folder.level == ROOT[:level]
    folder.destroy
  end

end