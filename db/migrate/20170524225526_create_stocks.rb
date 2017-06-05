class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :gid
      t.string :name
      t.integer :lastestpri
      t.integer :markvalue
      t.integer :priearn
      t.integer :ror
      t.time :ustime
      t.string :minurl

      t.timestamps
    end
    add_index :stocks, :gid
  end
end
