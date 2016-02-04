# Question Cove ![Travis build status](https://travis-ci.org/severest/question-cove.svg?branch=master) ![Code Climate](https://codeclimate.com/github/severest/question-cove/badges/gpa.svg)

A Stack Overflow inspired application to facilitate questions and answers written in Ruby on Rails.

View [the demo](https://questioncove.thealtitude.ca).

REQUIRES MySQL 5.6 (Full text search)

## Development

```
bundle install
rake db:setup
rails s
```

**Emails**

Go to <http://localhost:3000/emails> to view emails sent by the application is development mode

**Turning off demo mode**

Set the following option in `config/application.rb` to false:

```
config.demo_mode = true;
```

## Deployment

The application is setup to use [Capistrano](https://github.com/capistrano/capistrano) as a deployment method. Simply add the appropriate environment files to the directory `config/deploy/`. You can learn more about Capistrano by visiting the link.
