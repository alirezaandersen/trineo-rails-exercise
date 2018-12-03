FactoryBot.define do
  factory :item do
    sequence(:title) { |n| "Item #{n}" }
    completed 'false'
    todo

  end
end
