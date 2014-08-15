desc 'Twitter Cronjob'
task :refresh_twitter => :environment do
  TwitterReader.cronjob
end
