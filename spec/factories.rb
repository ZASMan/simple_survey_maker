FactoryBot.define do
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
