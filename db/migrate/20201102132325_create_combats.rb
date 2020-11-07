class CreateCombats < ActiveRecord::Migration[6.0]
  def change
    create_table :combats do |t|
      t.references :user, null: false, foreign_key: true

      t.integer :battle_record, default: 0, null: false
      t.timestamps
    end
  end
end
