module Validation
  
  module RegExps
    NAME = /\A(?=.{2,50}$)([A-Za-zÀ-ÖØ-öø-ÿ]+[- ']?[A-Za-zÀ-ÖØ-öø-ÿ]+)+\z/
    PASSWORD = /\A(?=.*[A-Za-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&^£$`'<>])[A-Za-z\d@$!%*#?&^£$`'<>]{8,}\z/
  end

  module Messages
    NAME = "must be 2-50 chars (only letters, spaces, - and ')."
    EMAIL = "is invalid."
    PASSWORD = "needs min. 8 chars: 1 number, 1 upper, 1 lower, 1 special."
  end

end