FactoryBot.define do
  factory :seedlingspost do
    item { "MyText" }
    product_regulation { "MyText" }
    shipping_date { "2019-12-15" }
    scion { "MyText" }
    rootstock { "MyText" }
    count { 1 }
    location { "MyText" }
    order_unit { 1 }
    remarks { "MyText" }
    user { nil }
  end
end
