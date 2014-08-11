task :refresh_twitter => :environment do
  TwitterReader.cronjob
end