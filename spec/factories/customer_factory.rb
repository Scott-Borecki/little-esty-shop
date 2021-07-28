FactoryBot.define do
  factory :customer do
    first_name { "Joe" }
    last_name  { "Schmo!" }
    # admin { false }
  end
end
