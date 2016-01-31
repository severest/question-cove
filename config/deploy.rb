# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'question-cove'
set :repo_url, 'git@github.com:severest/question-cove.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/apps/question-cove'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml', 'config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public/system')
