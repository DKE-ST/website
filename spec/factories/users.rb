# spec/factories/users.rb
require 'faker'

FactoryGirl.define do
  factory :user do | f |
    f.uname { Faker::Internet.user_name[0..7] }
    f.mit_id {Faker::Number.number(9)}
    f.group {["dkeaffil","dkepledge","dkeactive","dkealum"][(Random.rand * 4).floor]}
    f.chicken {["","broporn","brochicken"][(Random.rand * 3).floor]}
    f.password {Faker::Internet.password}
  end
end