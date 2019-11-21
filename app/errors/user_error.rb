module UserError

  INCORRECT_LOGIN = "Username or password is incorrect"

  class Unauthorized < StandardError
    def message
      "User is not authorized to view this page"
    end

    def status
      403
    end
  end

end