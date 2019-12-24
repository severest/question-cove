#!/bin/bash
set -e
bin/rails db:migrate
bin/rails s -b 0.0.0.0
