Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET'], scope: 'profile,email', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google', verify_iss: false
end

Rails.application.config.domain_whitelist = Regexp.new(ENV['DOMAINS'] || '.*')
