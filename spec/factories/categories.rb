# FactoryBot.define do
#     factory :category do
#       name {"レディース"}
#       ancestry { nil }
  
#       trait :category_children do
#         after(:build) do |f|
#           f.parent create(:category)
#         end

#         trait :category_grandchildren do 
#           after(:build) do |g|
#             g.parent create(:category_children)
#           end
#         end 
#       end 
      
#     end
#   end