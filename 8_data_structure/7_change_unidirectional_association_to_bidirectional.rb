# 片方向リンクから双方向リンクへ
# バックポインタを追加し、両方のポインタを書き換えるように更新メソッドを書き換える

##### Before #####
class Order
  attr_accessor :customer

end

require 'set'
class Customer
  def initialize
    @orders = Set.new
  end
end

##### After #####
class Order
  attr_reader :customer

  def customer=(value)
    customer.friend_orders.subtract(self) unless customer.nil?
    @customer = value
    customer.friend_orders.add(self) unless customer.nil?
  end

  #管理メソッド
  def add_customer(customer)
    customer.friend_orders.add(self)
    @customers.add(customer)
  end

  def remove_customer(customer)
    customer.friend_orders.subtract(self)
    @customers.subtract(customer)
  end

end

require 'set'

class Customer
  attr_reader :orders

  def initialize
    @orders = Set.new
  end

  def friend_orders
    @orders
  end

  def add_order(order)
    order.add_customer(self)
  end

  def remove_order(order)
    order.remove_customer(self)
  end
end