FactoryBot.define do
  factory :content_filter do
    filter_list { "MyText" }
  end
  factory :comment do
    
  end
  factory :answer do
    body "MyText"
    question nil
  end
  factory :question do
    title "MyString"
    description "MyText"
    survey nil
  end
  factory :survey do
    title "MyString"
    description "MyText"
  end
end
