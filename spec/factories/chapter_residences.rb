FactoryGirl.define do
  factory :chapter_residence, :class => 'Chapter::Residence' do |f|
    f.name  {Faker::Lorem.words.join(" ")}
    f.floor   {Faker::Number.digit}
    f.capacity  {Faker::Number.digit}
  end
  
  factory :invalid_chapter_residence, parent: :chapter_residence do |f|
    f.name nil
  end
end
