class DriveError < StandardError

  # attr_reader :message, :status

  # def initialize(message, status)

  class DocumentNotFound < DriveError
    def message
      "File not found"
    end

    def status
      404
    end
  end

  class FolderNotFound < DriveError
    def message
      "Folder not found"
    end

    def status
      404
    end
  end

  class RootDeletion < DriveError
    def message
      "Root folder cannot be deleted"
    end

    def status
      400
    end
  end

  class RootMove < DriveError
    def message
      "Root folder cannot be moved"
    end

    def status
      400
    end
  end
  

end