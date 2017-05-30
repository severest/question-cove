# Question Cove ![Travis build status](https://travis-ci.org/severest/question-cove.svg?branch=master) ![Code Climate](https://codeclimate.com/github/severest/question-cove/badges/gpa.svg)

A application to facilitate questions and answers written in Ruby on Rails.

View [the demo](https://questioncove.thealtitude.ca).

REQUIRES MySQL 5.6 (Full text search)

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
- Click 'Enable and manage APIs'.
- Make sure "Contacts API" and "Google+ API" are on.
- Go to Credentials, then select the "OAuth consent screen" tab on top, and provide an 'EMAIL ADDRESS' and a 'PRODUCT NAME'
- Create credentials > OAuth client ID
- Choose Web application
- Enter `<host>/auth/google/callback` as a Authorized redirect URIs (`http://localhost:3000/auth/google/callback` for local development)
- Enter the Client ID and secret in `config/initializers/omniauth.rb`
- Add email domains to `config.domain_whitelist` in `config/initializers/omniauth.rb`
  - Allow all emails: `Regexp.union(/.*/)`
  - Multiple domains: `Regexp.union(/@domain1.com/, /@domain2.com/)`


## Deployment

The application is setup to use [Capistrano](https://github.com/capistrano/capistrano) as a deployment method. Simply add the appropriate environment files to the directory `config/deploy/`. You can learn more about Capistrano by visiting the link.
