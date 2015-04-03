daily_coding_arr = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
User.create(username: "test", email: "test@test.com", password_hash: BCrypt::Password.create("password"))

50.times do
  User.create(username: Faker::Name.name, email: Faker::Internet.email, password_hash: BCrypt::Password.create("password"))
end

  Business.create(name: "Pranzi", address: "434 W Ontario St. Chicago, IL", daily_code: daily_coding_arr.sample(4).join(""), password_hash: BCrypt::Password.create("password"))

20.times do
  Business.create(name: Faker::Company.name, address: Faker::Address.street_address + " Chicago, IL", daily_code: daily_coding_arr.sample(4).join(""), password_hash: BCrypt::Password.create("password"))
end