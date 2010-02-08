Factory.define :user do |u|
  u.repo_url { Factory.next(:url) }
end

Factory.sequence :url do |n|
  "git://github.com/cool-github-nick#{n}/RNP-Contest-Bot.git"
end