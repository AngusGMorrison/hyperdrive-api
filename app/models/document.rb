class Document < ApplicationRecord
  belongs_to :user
  belongs_to :parent_folder, polymorphic: true
  has_one_attached :file_data, dependent: :purge

  validate :document_size

  private def document_size
    return if user.has_enough_storage?(byte_size)
    errors.add(:byte_size, Validation::Messages::DOCUMENT[:byte_size])
  end

  def file_extension
    filename.to_s.match(/\..+\z/)[0]
  end
end
