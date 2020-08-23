FactoryBot.define do

  factory :destination do
    destination_family_name                {"金子"}
    destination_first_name                 {"将也"}
    destination_family_name_kana         {"カネコ"}
    destination_first_name_kana          {"マサヤ"}
    postal_code                        {"0000000"}
    prefecture_id                            {"1"}
    city                              {"さいたま市"}
    address                         {"北区123-4"}
    building                          {"フリマビル"}
    phone_number                        {"09080807070"}
  end

end