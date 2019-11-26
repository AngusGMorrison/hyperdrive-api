class Document < ApplicationRecord
  belongs_to :folder
  belongs_to :user

  has_one_attached :file_data

  def get_file_extension
    self.filename.to_s.match(/\..+\z/)[0]
  end

  def self.format_date(date)
    date.strftime('%b %-d, %Y')
  end

end
