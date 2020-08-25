FactoryBot.define do
  factory :image do
      src { File.open("#{Rails.root}/spec/fixtures/sample.png") }
  end
end
