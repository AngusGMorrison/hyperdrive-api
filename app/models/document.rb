class Document < ApplicationRecord

  belongs_to :user
  belongs_to :containing_folder, polymorphic: true
  has_one_attached :file_data, dependent: :purge

  validate :document_size

  private def document_size
    if byte_size > user.remaining_storage_in_bytes
      errors.add(:byte_size, "is greater than remaining storage")
    end
  end

  def get_file_extension
    self.filename.to_s.match(/\..+\z/)[0]
  end

  def self.format_date(date)
    date.strftime('%b %-d, %Y')
  end

end
