FactoryBot.define do
  
  factory :CreditCard do
    user_id
    card_id
    customer_id  {cus_}
    
  end
end