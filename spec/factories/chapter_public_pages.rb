FactoryGirl.define do
  factory :chapter_public_page, :class => 'Chapter::PublicPage' do |f|
    f.pname   {Faker::Lorem.word}
    f.title   {Faker::Lorem.sentence}
    f.content   {Faker::Lorem.paragraphs.join("  ")}
  end
  
  factory :invalid_chapter_public_page, parent: :chapter_public_page do | f |
    f.title nil
  end
end
