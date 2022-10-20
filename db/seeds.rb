#初期データ用のユーザー
user = User.create!(id:0, name:"master_user", email:"master_user@masteruser.com", 
                    password:"master_user_password")

#初期データ用の大項目
income_items = ["給料", "ボーナス", "売上の回収", "その他"]
payment_items = ["住宅", "食費", "通信費", "交際費", "水道光熱費", "クレジットカード" ,"原価" ,"その他"]

income_items.each do |income_item| 
  Item.create!(user_id: 0, name: income_item, income_or_payment:1)
end

payment_items.each do |payment_item| 
  Item.create!(user_id: 0, name: payment_item, income_or_payment:2)
end

#動作確認用のお金の場所
3.times do |n|
  user.money_places.create!(name: "test_money_place#{n}" , date: Date.today, amount: 100)
end

#動作確認用の詳細項目
items = Item.all
items.each do |item|
  3.times do |n|
    item.detail_items.create!(user_id: 0, name: "detail_#{item.name}#{n}", income_or_payment: item.income_or_payment)
  end
end