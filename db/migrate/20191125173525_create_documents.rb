class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :filename
      t.string :content_type
      t.integer :byte_size
      t.references :folder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
