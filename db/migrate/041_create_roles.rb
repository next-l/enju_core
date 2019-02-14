class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table "roles" do |t|
      t.string :name, null: false, index: {unique: true}
      t.text :display_name, null: false
      t.text :note
      t.integer :position
      t.timestamps
    end
  end
end
