class CreatePicTags < ActiveRecord::Migration
  def self.up
    create_table :pic_tags do |t|
      t.string :pic_id
      t.string :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pic_tags
  end
end
