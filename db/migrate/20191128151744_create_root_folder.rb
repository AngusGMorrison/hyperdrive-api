class CreateRootFolder < ActiveRecord::Migration[6.0]
  def change
    create_table :root_folders do |t|
      t.references :user, index: true
    end
  end
end
