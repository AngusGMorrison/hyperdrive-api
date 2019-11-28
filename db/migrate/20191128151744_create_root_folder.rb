class CreateRootFolder < ActiveRecord::Migration[6.0]
  def change
    create_table :root_folders do |t|
      t.references :user_id, index: true
    end
  end
end
