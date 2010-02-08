Factory.define :user do |u|
  u.nick { Factory.next(:nick) }
  u.repo_name "TestRepo"
end

Factory.sequence :nick do |n|
   "cool-github-nick#{n}"
 end