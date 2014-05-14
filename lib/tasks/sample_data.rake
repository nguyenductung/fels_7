namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships
  end
end

def make_users
  User.create!(name: "Nguyen Duc Tung",
               email: "nguyen.duc.tung@framgia.com",
               password: "123456",
               password_confirmation: "123456",
               admin: true)
                 
  User.create!(name: "Example User",
               email: "example@railstutorial.org",
               password: "123456",
               password_confirmation: "123456",
               admin: true)
                 
  98.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password  = "123456"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end