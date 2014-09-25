# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_brother, :class => 'User::Brother' do |f|
    f.first_name  {Faker::Name.first_name}
    f.last_name   {Faker::Name.first_name}
    f.phone   {Faker::Number.number(10)}
    f.email   {Faker::Internet.safe_email}
    f.bio   {Faker::Lorem.paragraph}
    f.activities  {Faker::Lorem.words.join(", ")}
    f.hobbies   {Faker::Lorem.words.join(", ")}
    f.pro_team  {Faker::Company.name}
    f.college_team  {Faker::Company.name}
    f.movie   {Faker::Lorem.word}
    f.quote   {Faker::Lorem.sentence}
    f.hometown  {"#{Faker::Address.city}, #{Faker::Address.state_abbr}"}
    f.dke_info {FactoryGirl.build(:user_brother_dke_info)}
    f.mit_info {FactoryGirl.build(:user_brother_mit_info)}
  end
end
