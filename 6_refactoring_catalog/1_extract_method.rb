# メソッドの抽出（Extract Method）
# コードの断片をメソッドにして、その目的を説明する名前をつける


###### 簡単な例 ######

def print_owing(amount)
  print_banner
  puts "name: #{@name}"
  puts "amount: #{amount}"
end

##### 修正後 #####

def print_owing(amount)
  print_banner
  print_details(amount)
end

def print_details(amount)
  puts "name: #{@name}"
  puts "amount: #{amount}"
end

# 長すぎるメソッドや、何をしているのかわかりにくいメソッドに目を向ける
# そして、そのコード片を独自メソッドにまとめる


##### 別の例 #####

def print_owing(previous_amount)
  outstanding = previous_amount * 1.2

  # バナーの印刷（print banner）
  puts "*************************"
  puts "***** Customer Owes *****"
  puts "*************************"

  # 勘定の計算（calculate outstanding）
  @orders.each do |order|
    outstanding += order.amount
  end

  # 詳細の印刷（print details）
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

#コメントはメソッドの抽出を促すサイン。コメント自体がメソッドの名前になることもある
##### 修正後 #####

def print_owing(previous_amount)
  outstanding = previous_amount * 1.2
  print_banner
  outstanding = calclate_outstanding(outstanding)
  print_details(outstanding)
end

def print_banner
  puts "*************************"
  puts "***** Customer Owes *****"
  puts "*************************"
end

def print_details(outstanding)
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

def calclate_outstanding(initial_value)
  @orders.inject(initial_value) { |result, order| result + order.amount }
end