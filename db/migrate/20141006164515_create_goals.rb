class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null:false
      t.text :description
      t.integer :author_id, null:false
      t.boolean :completed, null:false, default: false
      t.boolean :public, null:false, default: true

      t.timestamps
    end

    add_index :goals, :author_id
  end
end
