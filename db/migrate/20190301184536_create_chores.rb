class CreateChores < ActiveRecord::Migration[5.2]
  def change
    create_table :chores do |t|
      t.timestamp :run_at, null: :false

      t.timestamps
    end
  end
end
