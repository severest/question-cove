#!/bin/bash
set -e
QUEUES=mailers,default bundle exec rake jobs:work
