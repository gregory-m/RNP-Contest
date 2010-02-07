# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rnp_contest_session',
  :secret      => '4e37dd5fade63fb6c58a34c61ab656c297c98260ba18b716e8892386e40af7418bf8765a2057cd95ea4499362517f8a0f8258e72928ef6e7420abbe79446b604'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
