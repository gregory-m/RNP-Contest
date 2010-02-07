Factory.define :user do |u|
  u.nick { Factory.next(:nick) }
end

Factory.sequence :nick do |n|
   "cool-github-nick#{n}"
 end