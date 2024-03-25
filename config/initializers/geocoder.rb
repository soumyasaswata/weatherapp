# config/initializers/geocoder.rb

Geocoder.configure(
  lookup: :google,
  api_key: 'YOUR_GOOGLE_MAPS_API_KEY',
  use_https: true,
  units: :km  # Optional: Use kilometers as the default unit
)
