#初期データ用のユーザー
user = User.create!(id:0, name:"master_user", email:"master_user@masteruser.com", 
                    password:"master_user_password")

#初期データ用の大項目
items = ["給料", "ボーナス", "売上の回収", "その他",
         "住宅", "食費", "通信費", "交際費", "水道光熱費", "クレジットカード" ,"原価" ,"その他"]
items.each do |item| 
  Item.create!(user_id: 0, name: item)
end

#動作確認用のお金の場所
3.times do |n|
  user.money_places.create!(name: "test_money_place#{n}" , date: Date.today, amount: 100)
end

#動作確認用の詳細項目
items = Item.all
items.each do |item|
  3.times do |n|
    item.detail_items.create!(user_id: 0, name: "detail_#{item.name}#{n}")
  end
end