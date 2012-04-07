class Person < ActiveRecord::Base
      extend PreferencesHelper
  
  MAX_EMAIL = MAX_PASSWORD = 40
  MAX_NAME = 40
  MAX_DESCRIPTION = 5000
  EMAIL_REGEX = /\A[A-Z0-9\._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i
  TRASH_TIME_AGO = 1.month.ago
  SEARCH_LIMIT = 20
  SEARCH_PER_PAGE = 8
  MESSAGES_PER_PAGE = 5
  NUM_RECENT_MESSAGES = 4
  NUM_WALL_COMMENTS = 10
  NUM_RECENT = 8
  FEED_SIZE = 10
  MAX_DEFAULT_CONTACTS = 12
  TIME_AGO_FOR_MOSTLY_ACTIVE = 1.month.ago
  
  attr_accessor :password, :verify_password, :new_password,
                :sorted_photos
  attr_accessible :email, :password, :password_confirmation, :name,
                  :description
  
  validates_presence_of     :email, :name
  validates_presence_of     :password,              :if => :password_required?
  validates_presence_of     :password_confirmation, :if => :password_required?
  validates_length_of       :password, :within => 4..MAX_PASSWORD,
                                       :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :email, :within => 6..MAX_EMAIL
  validates_length_of       :name,  :maximum => MAX_NAME
  validates_length_of       :description, :maximum => MAX_DESCRIPTION
  validates_format_of       :email,
                            :with => EMAIL_REGEX,
                            :message => "must be a valid email address"
  validates_uniqueness_of   :email
  
  
  def password_required?
      (crypted_password.blank?) || !password.blank? ||
      !verify_password.nil?
  end
  
end