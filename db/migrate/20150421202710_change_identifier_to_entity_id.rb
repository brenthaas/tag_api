class ChangeIdentifierToEntityId < ActiveRecord::Migration
  def change
    change_table :entities do |t|
      t.rename :identifier, :entity_id
    end
  end
end
