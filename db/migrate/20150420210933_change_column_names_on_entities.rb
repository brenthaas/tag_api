class ChangeColumnNamesOnEntities < ActiveRecord::Migration
  def change
    change_table :entities do |t|
      t.rename :type, :entity_type
    end
  end
end
