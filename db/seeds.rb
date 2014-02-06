def fake_twitter_id
  Array.new(32) { rand(36).to_s(36) }.join
end

Organizer.create! username: 'ruby_dresden',
             email: 'info@ruby-dresden.de',
             password: 'password',
             password_confirmation: 'password',
             twitter_account: '@ruby_dresden'

Organizer.create! username: 'webmontagdresden',
             email: 'info@example.com',
             password: 'password',
             password_confirmation: 'password',
             twitter_account: '@webmontagdd'

Event.create! text: 'Ruby User Group Dresden Event 1',
              happens_at: 4.weeks.from_now,
              organizer: User.first,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Ruby User Group Dresden Event 2',
              happens_at: 8.weeks.from_now,
              organizer: User.first,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Web Montag Dresden Event 1',
              happens_at: 6.weeks.from_now,
              organizer: User.all.second,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Web Montag Dresden Event 2',
              happens_at: 12.weeks.from_now,
              organizer: User.all.second,
              link: 'http://',
              twitter_id: fake_twitter_id


# User.create! username: 'admin',
#   email: 'info@example.com',
#   password: 'password',
#   password_confirmation: 'password'
