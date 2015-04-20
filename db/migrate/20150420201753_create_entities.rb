class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :type
      t.string :identifier, unique: true

      t.timestamps null: false
    end
  end
end
