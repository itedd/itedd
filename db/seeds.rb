def fake_twitter_id
  Array.new(32) { rand(36).to_s(36) }.join
end

User.create! email: 'info@ruby-dresden.de',
             password: 'password',
             password_confirmation: 'password'

User.create! email: 'info@example.com',
             password: 'password',
             password_confirmation: 'password'

UserGroup.create! name: 'webmontagdresden',
             twitter_account: '@webmontagdd',
             color: '#ffffff',
             user_group: User.first

UserGroup.create! name: 'ruby-dresden',
             twitter_account: '@ruby_dresden',
             color: '#ffffff',
             user_group: User.all.second

Event.create! text: 'Ruby User Group Dresden Event -1',
              happens_at: 4.weeks.ago,
              user_group: UserGroup.first,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Ruby User Group Dresden Event -2',
              happens_at: 8.weeks.ago,
              user_group: UserGroup.first,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Web Montag Dresden Event -1',
              happens_at: 6.weeks.ago,
              user_group: UserGroup.all.second,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Web Montag Dresden Event -2',
              happens_at: 12.weeks.ago,
              user_group: UserGroup.all.second,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Ruby User Group Dresden Event 1',
              happens_at: 4.weeks.from_now,
              user_group: UserGroup.first,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Ruby User Group Dresden Event 2',
              happens_at: 8.weeks.from_now,
              user_group: UserGroup.first,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Web Montag Dresden Event 1',
              happens_at: 6.weeks.from_now,
              user_group: UserGroup.all.second,
              link: 'http://',
              twitter_id: fake_twitter_id

Event.create! text: 'Web Montag Dresden Event 2',
              happens_at: 12.weeks.from_now,
              user_group: UserGroup.all.second,
              link: 'http://',
              twitter_id: fake_twitter_id
