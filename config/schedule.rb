# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, :production
every :week do
  runner "Tasks::Batch.crowl"
  runner "Tasks::Batch.set_status"
end

# every '30 3 1 * *' do
every 6.hours do
  rake 'sitemap:refresh'
end

every '0 1 * * *' do
  runner "Tasks::Batch.update_comment"
end
