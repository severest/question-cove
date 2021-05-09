# Question Cove [![Build Status](https://sean.semaphoreci.com/badges/question-cove/branches/master.svg?style=shields)](https://sean.semaphoreci.com/projects/question-cove)

A application to facilitate questions and answers written in Ruby on Rails.

REQUIRES MySQL >= 5.6 

## Development

```
bundle install
rake db:create
rake db:migrate
rails s
```

**Emails**

Go to <http://localhost:3000/emails> to view emails sent by the application is development mode


## Authentication

This app uses Google OAuth to authenticate users. To set up, follow these steps:

- Go to 'https://console.developers.google.com'
- Select your project.
- Go to Credentials, then select the "OAuth consent screen" tab on top, and provide an 'EMAIL ADDRESS' and a 'PRODUCT NAME'
- Create credentials > OAuth client ID
- Choose Web application
- Enter `<host>/auth/google/callback` as a Authorized redirect URIs (`http://localhost:3000/auth/google/callback` for local development)
- Enter the Client ID and secret in `config/initializers/omniauth.rb`
- Add email domains to `config.domain_whitelist` in `config/initializers/omniauth.rb`
  - Allow all emails: `Regexp.union(/.*/)`
  - Multiple domains: `Regexp.union(/@domain1.com/, /@domain2.com/)`
