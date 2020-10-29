Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['LOGIN_GOOGLE']
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET'], scope: 'profile,email', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google', verify_iss: false
  end
  if ENV['LOGIN_SG']
    provider :sevengeese, ENV['SG_CLIENT_ID'], ENV['SG_SECRET']
  end
end

Rails.application.config.domain_whitelist = Regexp.new(ENV['DOMAINS'] || '.*')
Rails.application.config.sg_login = ENV['LOGIN_SG']
Rails.application.config.google_login = ENV['LOGIN_GOOGLE']
