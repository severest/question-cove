Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "530648988481-n7qqsfn0524110cgev2gi6b5i94h68ca.apps.googleusercontent.com", "IuwN--VJBXJWkCua8s9LzxhF", scope: 'profile,email', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
end
