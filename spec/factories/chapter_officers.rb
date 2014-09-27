FactoryGirl.define do
  factory :chapter_officer, :class => 'Chapter::Officer' do |f|
    f.name  {Faker::Lorem.word}
    f.title   {Faker::Lorem.sentence}
    f.position  {Faker::Number.number(2)}
    f.disp  {Faker::Number.digit.to_i>5}
    f.contact   {Faker::Lorem.sentence}
    f.email   {Faker::Internet.email}
  end
  
  factory :invalid_chapter_officer, parent: :chapter_officer do |f|
    f.name nil
    f.title nil
  end
end
