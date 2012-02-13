class CreatePicconnects < ActiveRecord::Migration
  def self.up
    create_table :picconnects do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :picconnects
  end
end
