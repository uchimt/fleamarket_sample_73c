FactoryBot.define do
    factory :category do
      name {"ゴリラ"}
      ancestry {nil}
  
      factory :category_children do |f|
        f.parent create(:category_parent_array)
  
        factory :category_grandchildren do |g|
          g.parent create(:category_children)
        end
  
      end 
  
    end
  end