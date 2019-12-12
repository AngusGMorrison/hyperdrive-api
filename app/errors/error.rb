module Error

  module ErrorHandler
    def self.included(target_class)
      target_class.class_eval do
        rescue_from ActionController::ParameterMissing, with: :respond_with_error
        rescue_from UnauthorizedUser, with: :respond_with_error
        rescue_from RootFolderDeletion, with: :respond_with_error
        rescue_from RootFolderMove, with: :respond_with_error
        rescue_from OwnedObjectNotFound, with: :respond_with_error
      end
    end

    private def respond_with_error(error)
      render json: { errors: error.message }, status: error.status || 400
    end
  end

  class HyperdriveError < StandardError
    attr_reader :message, :status

    def initialize(message="Something went wrong", status=400)
      @message = message
      @status = status
    end
  end

  class UnauthorizedUser < HyperdriveError
    def initialize
      super("User is not authorized to view this page", 403)
    end
  end

  class MissingRootFolder < HyperdriveError
    def initialize
      super("Root folder is missing. This shouldn't happen.", 500)
    end
  end

  class RootFolderDeletion < HyperdriveError
    def initialize
      super("Root folder cannot be deleted", 400)
    end
  end

  class RootFolderMove < HyperdriveError
    def initialize
      super("Root folder cannot be moved", 400)
    end
  end

  class OwnedObjectNotFound < HyperdriveError
    def initialize(class_name)
      super(class_name + " not found for the current user", 404)
    end
  end

  class SerializerNotFound < HyperdriveError
    def initialize(serializer_name)
      super("Couldn't find a serializer called " + serializer_name, 500)
    end
  end

end