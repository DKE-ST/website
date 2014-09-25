FactoryGirl.define do
  factory :user_brother_dke_info, :class => 'User::Brother::DkeInfo' do |f|
    f.p_name  {Faker::Lorem.sentence}
    f.project   {Faker::Lorem.sentence}
    f.past_pos  {Faker::Lorem.sentence}
    f.p_class   {Faker::Business.credit_card_expiry_date.year}
  end
end