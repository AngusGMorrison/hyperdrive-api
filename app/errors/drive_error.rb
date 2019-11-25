class DriveError < StandardError

  class FileNotFound < DriveError
    def message
      "File not found"
    end

    def status
      404
    end
  end

end