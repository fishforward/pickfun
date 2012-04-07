class CreateOauths < ActiveRecord::Migration
  def self.up
    create_table :oauths do |t|
      t.string :uuid
      t.string :app
      t.string :key_id
      t.string :name
      t.string :name2
      t.string :memo
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :oauths
  end
end
