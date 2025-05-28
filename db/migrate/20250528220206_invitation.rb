class Invitation < ActiveRecord::Migration[8.0]
  def change
    create_table :rsvps do |t|
      t.string :status
      t.references :event, null: false, foreign_key: true
      t.references :guest, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
