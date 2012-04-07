class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table "people", :force => true do |t|
      t.string   :uuid, :longin, :email, :name, :remember_token, :crypted_password, :salt
      t.text     :description
      t.datetime :remember_token_expires_at,
                 :last_contacted_at,
                 :last_logged_in_at
      t.integer  :pics_count, :null => false, :default => 0
      t.integer  :picks_count, :null => false, :default => 0
      t.string   :email_verified, :avatar, :status, :admin, :email_verified_url
      t.timestamps
    end
  end

  def self.down
    drop_table "people"
  end
end