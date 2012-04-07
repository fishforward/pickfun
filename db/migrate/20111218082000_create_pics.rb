class CreatePics < ActiveRecord::Migration
  def self.up
    create_table :pics do |t|
      t.string :keyname
      t.string :subject
      t.string :title         #后面去掉好了，sina导入图片没用这个字段
      t.string :description
      t.string :image_url     #上传时使用，图片原名称
      t.string :original_pic  #原图
      t.string :bmiddle_pic   #中等尺寸
      t.string :thumbnail_pic #缩略图
      t.integer :scores
      t.integer :wins
      t.integer :losses
      t.string :tmptags
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :pics
  end
end
