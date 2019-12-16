User.create!(
  name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
  )
end

params = {
  item: "MyText",
  product_regulation: "MyText",
  shipping_date: "2019-12-15",
  scion: "MyText",
  rootstock: "MyText",
  count: 1,
  location: "MyText",
  order_unit: 1,
  remarks: "MyText",
}

users = User.order(:created_at).take(6)
50.times do
  users.each {|user| user.seedlingsposts.create!(params) }
end
