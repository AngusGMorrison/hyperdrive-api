class DriveError < StandardError

  class DocumentNotFound < DriveError
    def message
      "File not found"
    end

    def status
      404
    end
  end

end