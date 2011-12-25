class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :code
      t.string :name
      t.string :link
      t.string :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :subjects
  end
end
