Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "530648988481-7tvmr3p5hb17ufof3qdk182ocv93vplh.apps.googleusercontent.com", "jHoN0bJUiAtRd74x0JfvGMlV", scope: 'profile,email', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google', verify_iss: false
end

Rails.application.config.domain_whitelist = Regexp.union(/.*/)
