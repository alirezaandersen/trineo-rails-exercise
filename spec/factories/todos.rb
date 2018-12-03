FactoryBot.define do

  factory :todo do
    sequence(:title)  { |n| "Todo #{n}" }
    completed 'false'
  end

end
