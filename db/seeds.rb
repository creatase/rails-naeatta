# ユーザー
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

# 苗情報投稿
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

# リレーションシップ
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed) }
followers.each {|follower| follower.follow(user) }
