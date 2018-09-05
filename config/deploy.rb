# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'question-cove'
set :repo_url, 'https://github.com/severest/question-cove.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '~/question-cove'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/initializers/omniauth.rb', 'config/initializers/slack.rb', 'config/settings.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

# Number of delayed_job workers
# default value: 1
set :delayed_job_workers, 1

# String to be prefixed to worker process names
# This feature allows a prefix name to be placed in front of the process.
# For example:  reports/delayed_job.0  instead of just delayed_job.0
set :delayed_job_prefix, 'questioncove'

# Delayed_job queue or queues
# Set the --queue or --queues option to work from a particular queue.
# default value: nil
set :delayed_job_queues, ['mailers', 'default']

# Set the roles where the delayed_job process should be started
# default value: :app
set :delayed_job_roles, [:app]
