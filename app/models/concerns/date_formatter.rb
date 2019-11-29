module DateFormatter

  def self.format_date(date)
    date.strftime('%b %-d, %Y')
  end

end