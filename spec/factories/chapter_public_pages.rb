FactoryGirl.define do
  factory :chapter_public_pages, :class => 'Chapter::PublicPage' do |f|
    f.pname   {Faker::Lorem.word}
    f.title   {Faker::Lorem.sentence}
    f.content   {Faker::Lorem.paragraphs.join("  ")}
  end
end
