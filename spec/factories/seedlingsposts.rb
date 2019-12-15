FactoryBot.define do
  factory :seedlingspost do
    item { "MyText" } # 品目
    product_regulation { "MyText" } # 規格
    shipping_date { "2019-12-15" } # 出荷日
    scion { "MyText" } # 穂木
    rootstock { "MyText" } # 台木
    count { 1 } # 本数
    location { "MyText" } # 生産地
    order_unit { 1 } # 発注単位
    remarks { "MyText" } # 備考
    user { nil }
  end
end
