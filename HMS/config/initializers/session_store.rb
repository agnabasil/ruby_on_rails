# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hospital_management_system_session',
  :secret      => 'a668bc4f91424c8e1bcb80f8068caec88ada8f8520a900d6be5fa7a1fc7f885026bf7dc7c13d03f1ffef27aa1449230b5fbae20a500b025b1572a930bb0fdf8b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
