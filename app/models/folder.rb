class Folder < ApplicationRecord

  ROOT = '__root__'
  scope :root, -> { find_by(name: ROOT)}

  belongs_to :user
  has_many :documents

  has_many_attached :files

  def self.get_file_extension(file)
    file.filename.to_s.match(/\..+\z/)[0]
  end

  def self.format_file_date(date)
    date.strftime('%b %-d, %Y')
  end

end