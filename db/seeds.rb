# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# ruby encoding: utf-8

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
     

48.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password  = "123456"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end


users = User.all
user  = users.first
followed_users = users[2..30]
followers      = users[10..35]
followed_users.each { |followed| user.follow!(followed) }
followers.each      { |follower| follower.follow!(user) }


categories = [
  ["Động vật", "Từ vựng chủ đề Động vật"],
  ["Giao thông", "Từ vựng chủ đề Giao thông"],
  ["Kinh tế", "Từ vựng chủ đề Kinh tế"],
  ["Tin học", "Từ vựng chủ đề Tin học"],
  ["Mua sắm", "Từ vựng chủ đề Mua sắm"],
  ["Thường ngày", "Từ vựng chủ đề Thường ngày"],
  ["Bệnh viện", "Từ vựng chủ đề Bệnh viện"]
]

  categories.each do |name, description|
    Category.create( name: name, description: description )
  end

words = [
  [ "ねこ", "mèo" ],
  [ "かめ", "rùa" ],
  [ "くま", "gấu" ],
  [ "ねずみ", "chuột" ],
  [ "りゅう", "rồng" ],
  [ "さる", "khỉ" ],
  [ "さかな", "cá" ],
  [ "しか", "hươu" ],
  [ "たこ", "bạch tuộc" ],
  [ "とら", "hổ" ],
  [ "とり", "chim" ],
  [ "うま", "ngựa" ],
  [ "うさぎ", "thỏ" ],
  [ "うし", "bò" ],
  [ "ぶた", "lợn" ],
  [ "えび", "tôm" ],
  [ "ひつじ", "cừu" ],
  [ "いぬ", "chó" ],
  [ "いるか", "cá heo" ],
  [ "きつね", "cáo" ],
  [ "らくだ", "lạc đà" ],
  [ "はと", "chim bồ câu" ],
  [ "へび", "rắn" ],
  [ "ほたる", "đom đóm" ],
  [ "はえ", "ruồi" ],
  [ "あり", "kiến" ],
  [ "まぐろ", "cá ngừ" ],
  [ "くじら", "cá voi" ],
  [ "ぞう", "voi" ],
  [ "いか", "mực" ]
]

option_contents = []
category_id = Category.find_by(name: "Động vật").id
words.each do |content, meaning|
  Word.create(content: content, meaning: meaning, category_id: category_id)
  option_contents << meaning
end

words = Word.where(category_id: category_id)
words.each do |word|
  Option.create(content: word.meaning, is_correct: true, word_id: word.id)
  contents = option_contents.reject{|c| c == word.meaning}.sample(3)
  contents.each do |content|
    Option.create(content: content, is_correct: false, word_id: word.id)
  end
end

2.times do |n|
  lesson = Lesson.new(user_id: 1, category_id: category_id)
  words = Word.where(category_id: category_id).sample(20)
  words.each do |word|
    option = word.options.sample
    #Answer.new(user_id: 1, word_id: word.id, option_id: option.id, lesson_id: lesson.id)
    lesson.answers.build(user_id: 1, word_id: word.id, option_id: option.id)
  lesson.save  
  end
end

words = [
  [ "でんしゃ", "tàu điện" ],
  [ "ひこうき", "máy bay" ],
  [ "ふね", "thuyền" ],
  [ "じてんしゃ", "xe đạp" ],
  [ "バイク", "xe máy" ],
  [ "バス", "xe bus" ],
  [ "くるま", "xe ôtô" ],
  [ "タクシー", "xe taxi" ],
  [ "トラック", "xe tải" ],
  [ "ちかてつ", "tàu điện ngầm" ],
  [ "きゅうきゅうしゃ", "xe cứu thương" ],
  [ "しんかんせん", "tàu siêu tốc" ],
  [ "ヘリコプター", "máy bay trực thăng" ],
  [ "フェリー", "phà" ],
  [ "させつ", "rẽ trái" ],
  [ "うせつ", "rẽ phải" ],
  [ "こうさてん", "ngã tư" ],
  [ "しんごう", "đèn giao thông" ],
  [ "どうろ", "đường cao tốc" ],
  [ "げんそく", "giảm tốc độ" ],
  [ "ぞうそく", "tăng tốc độ"],
  [ "ちょくしん", "đi thẳng" ],
  [ "ストップ", "dừng lại" ],
  [ "ほどう", "vỉa hè" ],
  [ "えき", "nhà ga" ],
  [ "くうこう", "sân bay" ],
  [ "はし", "cầu" ],
  [ "まがる", "rẽ" ],
  [ "きっぷ", "vé xe" ],
  [ "おうふく", "khứ hồi" ]
]

option_contents = []
category_id = Category.find_by(name: "Giao thông").id
words.each do |content, meaning|
  Word.create(content: content, meaning: meaning, category_id: category_id)
  option_contents << meaning
end

words = Word.where(category_id: category_id)
words.each do |word|
  Option.create(content: word.meaning, is_correct: true, word_id: word.id)
  contents = option_contents.reject{|c| c == word.meaning}.sample(3)
  contents.each do |content|
    Option.create(content: content, is_correct: false, word_id: word.id)
  end
end

lesson = Lesson.new(user_id: 1, category_id: category_id)
words = Word.where(category_id: category_id).sample(20)
words.each do |word|
  option = word.options.sample
  lesson.answers.build(user_id: 1, word_id: word.id, option_id: option.id)
lesson.save 
end
