# サブクラスの抽出
# クラスが一部のインスタンスだけしか使わないメンバを持っている場合、それらのメンバをサブクラスに移動させる

##### Before #####
class JobItem
  attr_reader :quantity, :employee

  def initialize(unit_price, quantity, is_labor, employee)
    @unit_price = unit_price
    @quantity = quantity
    @is_labor = is_labor
    @employee = employee
  end

  def total_price
    unit_price * @quantity
  end

  def unit_price
    labor? ? @employee.rate : @unit_price
  end

  def labor?
    @is_labor
  end
end

class Employee
  attr_reader :rate

  def initialize(rate)
    @rate = rate
  end
end

##### After #####

class JobItem
  attr_reader :quantity, :unit_price

  def initialize(unit_price, quantity)
    @unit_price = unit_price
    @quantity = quantity
  end

  def total_price
    unit_price * @quantity
  end
end

class LaborItem < JobItem
  attr_reader :employee

  def initialize(quantity, employee)
    super(employee.rate, quantity)
    @employee = employee
  end
end

class Employee
  attr_reader :rate

  def initialize(rate)
    @rate = rate
  end
end
