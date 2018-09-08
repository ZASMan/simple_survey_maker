FactoryBot.define do
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
