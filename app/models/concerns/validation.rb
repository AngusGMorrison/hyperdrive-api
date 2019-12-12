module Validation
  
  module RegExps
    NAME = /\A(?=.{2,50}$)([A-Za-zÀ-ÖØ-öø-ÿ]+[- ']?[A-Za-zÀ-ÖØ-öø-ÿ]+)+\z/
    PASSWORD = /\A(?=.*[A-Za-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&^£$`'<>])[A-Za-z\d@$!%*#?&^£$`'<>]{8,}\z/
  end

  module Messages
    USER = {
      name: 'must be 2-50 chars (only letters, spaces, - and \').'
      email: 'is invalid.'
      password: 'needs min. 8 chars: 1 number, 1 upper, 1 lower, 1 special.'
    }

    FOLDER = {
      immutable_root: 'Root folder cannot be modified.',
      parent_folder_required: 'is required for non-root folders.',
      root_has_parent: 'cannot be added to a root folder.',
      own_parent: 'must be different to current folder.'
    }

    DOCUMENT = {
      byte_size: 'is greater than remaining storage.'
    }
  end

end