# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'admin@admin',
   password: 'tttttt'
)

Post.find_or_create_by!(title: "Cavello") do |post|
  post.body = "大人気のカフェです。"
  post.address = "東京都千代田区丸の内1丁目"
  post.user = olivia
end

Post.find_or_create_by!(title: "和食屋せん") do |post|
  post.body = "日本料理は美しい！"
  post.address = "愛知県名古屋市中村区名駅１丁目１−４"
  post.user = james
end

Post.find_or_create_by!(title: "ShoreditchBar") do |post|
  post.body = 'メキシコ料理好きな方にオススメ！'
  post.address = "大阪府大阪市淀川区西中島5-16-1" 
  post.user = lucas
end