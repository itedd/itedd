desc 'Twitter Cronjob'
task :refresh_twitter => :environment do
  TwitterReader.cronjob
end

desc 'Ical Cronjob'
task :refresh_ical => :environment do
  IcalReader.cronjob
end

desc 'Meetup.com Cronjob'
task :refresh_meetup => :environment do
  MeetupReader.cronjob
end
