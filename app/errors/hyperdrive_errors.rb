module HyperdriveErrors

  class UnauthorizedUser < StandardError
    def message
      "User is not authorized to view this page"
    end

    def status
      403
    end
  end

end