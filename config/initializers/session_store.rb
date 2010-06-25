# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_help-me-hacker_session',
  :secret      => 'f8467b769ae28a57a4c739bd031ffa76e7cc832c8379cdb6dd8317d78d94fa3cc08e3c4260c58a3f0442fa8fa2725ac32e1602f59c628b8d89064178261a746f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
