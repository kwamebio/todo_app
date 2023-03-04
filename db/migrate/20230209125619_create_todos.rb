class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
