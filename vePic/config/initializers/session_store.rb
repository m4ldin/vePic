# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_vePic_session',
  :secret      => 'd29e9ce0c22972650546eee21b7ac31e41dcdc39f8802b5320e40fe3df89417b6c8f85e3504618822da674ec90354f5e7fd22c72dd4b9031c67ca1fc35617590'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
