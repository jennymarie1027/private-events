class AddEventTitleAndDesc < ActiveRecord::Migration[8.0]
  def change
    change_table :events do |t|
      t.string :title, null: false
      t.text :description, null: false, default: ""
    end
  end
end
