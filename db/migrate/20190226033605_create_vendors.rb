class CreateVendors < ActiveRecord::Migration[5.2]
  def change
    create_table :vendors do |t|
      t.string :name, presence: true

      t.timestamps
    end
    add_index :vendors, :name, unique: true
  end
end
