class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  add_template_helper Gravatarify::Helper
end
