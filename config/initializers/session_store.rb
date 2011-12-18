# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pickpic_session',
  :secret      => '06cf02017d4eb738e70b749ad993e248eabcfed70c9ca4c854b212728c7b5277108bc31443b618129da7492175aa74bc4189e11f395f5f910c5185917549f735'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
