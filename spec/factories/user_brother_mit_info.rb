FactoryGirl.define do
  factory :user_brother_mit_info, :class => 'User::Brother::MitInfo' do |f|
    majors  {Faker::Commerce.department}
    minors  {Faker::Commerce.department}
    concentration   {Faker::Commerce.department}
    extracurriculars  {Faker::Commerce.department}
    interests   {Faker::Lorem.words.join(", ")}
    urops   {Faker::Commerce.department}
    internships   {Faker::Company.name}
    fav_classes   {Faker::Lorem.words.join(", ")}
    year  {Faker::Business.credit_card_expiry_date.year}
  end
end