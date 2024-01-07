# レコードからデータクラスへ
# レコードのためにデータオブジェクトを作成する

# 例題: レコードからデータクラスへ(ChatGTPより提供)

##### Before #####
# ハッシュを使用して顧客データを表現
customer = {
  name: "Alice",
  email: "alice@example.com"
}

# データへのアクセス
puts customer[:name]
puts customer[:email]


##### After #####
class Customer
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end

  # 追加できるデータに関連するメソッド
  def display_info
    puts "#{@name} - #{@email}"
  end
end

# データクラスの使用
customer = Customer.new("Alice", "alice@example.com")
customer.display_info
