class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :piece
      t.string :square
      t.integer :user_id
    end
  end
end
