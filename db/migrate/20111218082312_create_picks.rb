class CreatePicks < ActiveRecord::Migration
  def self.up
    create_table :picks do |t|
      t.string :user
      t.string :ip
      t.string :subject
      t.string :win_pic_id
      t.string :loss_pic_id

      t.timestamps
    end
  end

  def self.down
    drop_table :picks
  end
end
