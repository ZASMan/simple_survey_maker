FactoryBot.define do
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
