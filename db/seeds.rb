jugsaxony      = UserGroup.create! name: 'JUG Saxony',        twitter_account: '@jugsaxony',      color: '#ffffff'
agile_saxony   = UserGroup.create! name: 'Agile Saxony',      twitter_account: '@AgileSaxony',    color: '#ffffff'
cofab          = UserGroup.create! name: 'CoFab DD',          twitter_account: '@cofabdd',        color: '#ffffff'
rug            = UserGroup.create! name: 'ruby-dresden',      twitter_account: '@ruby_dresden',   color: '#ffffff'
webmontag      = UserGroup.create! name: 'WebMontag Dresden', twitter_account: '@webmontagdd',    color: '#ffffff'
wdcm           = UserGroup.create! name: 'WDCM Dresden',      twitter_account: '@wdcmdresden',    color: '#ffffff'
barcamp        = UserGroup.create! name: 'BarCamp Dresden',   twitter_account: '@startcampdd',    color: '#ffffff'
output         = UserGroup.create! name: 'Output Dresden',    twitter_account: '@outputdd',       color: '#ffffff'
agile_hardware = UserGroup.create! name: 'Agile Hardware',    twitter_account: '@agile_hardware', color: '#ffffff'

User.create! email: 'paul.fritsche@objectfab.de',
             password: 'password',
             password_confirmation: 'password',
             admin: true,
             approved:true

[
    jugsaxony, agile_hardware, agile_saxony, cofab, rug, webmontag, wdcm, barcamp, output
].each do |ug|
  User.create! email: "#{ug.twitter_account[1..-1]}@objectfab.de",
               password: 'password',
               password_confirmation: 'password',
               admin: false,
               approved: true,
               user_group: ug

end

