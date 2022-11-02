#!/bin/sh
set -e
cd /MoneyMoney
rm -f /myapp/tmp/pids/server.pid
#bundle exec rails db:create RAILS_ENV=production
bundle exec rails db:migrate:reset ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 
#bundle exec rails db:migrate RAILS_ENV=production
bundle exec rails db:seed RAILS_ENV=production
bundle exec rails assets:precompile RAILS_ENV=production
exec "$@"