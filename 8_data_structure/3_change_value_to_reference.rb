# 値から参照へ（change value to reference）
# そのオブジェクトを参照オブジェクトに変える

# Before
class Customer
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

private

def self.number_of_orders_for(orders, customer)
  orders.select { |order| order.customer == customer }.size
end

# After

class Customer
  def self.load_customers
    new("Lemon Car Hire").store
    new("Associated Coffee Machines").store
    new("Bilston Gasworks").store
  end

  def self.with_name(name)
    Instance[name]
  end
end

class Order
  def initialize(customer_name)
    @customer = Customer.create(customer_name)
  end
end

