# データ値からオブジェクトへ（replace data value with object）
# データ項目をオブジェクトに書き換える

# Before
class Order
  attr_accessor :customer

  def initialize(customer)
    @customer = customer
  end
end

# このクラスを使うクライアントコード
private

def self.number_of_orders_for(orders, customer)
  orders.select { |order| order.customer == customer }.size
end

# After

class customer
  attr_reader :name

  def  initialize(name)
    @name = name
  end
end

class Order

  def initialize(customer_name)
    @customer = Customer.new(customer_name)
  end

  def customer
    @customer.name
  end

  def customer=(customer_name)
    @customer = Customer.new(customer_name)
  end
end
