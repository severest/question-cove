Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "google-client-id", "google-secret", scope: 'profile,email', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
end

Rails.application.config.domain_whitelist = Regexp.union(/.*/)
