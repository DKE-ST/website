FactoryGirl.define do
  factory :chapter_residences, :class => 'Chapter::Residence' do |f|
    f.name  {Faker::Lorem.words.join(" ")}
    f.floor   {Faker::Number.digit}
    f.capacity  {Faker::Number.digit}
  end
end
