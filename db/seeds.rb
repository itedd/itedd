user = User.where(email: 'steffen.gemkow@objectfab.de').first_or_create!(
             password: 'password',
             password_confirmation: 'password',
             admin: true,
             approved:true
)

user.user_group ||= UserGroup.create! name: 'Ruby Dresden', website: 'http://www.ruby-dresden.de', twitter_account: '@ruby_dresden', color: '#000000'
user.save
