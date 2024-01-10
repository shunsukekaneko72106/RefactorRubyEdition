# 引数オブジェクトの導入

##### Before #####

class Account
  def add_charge(base_price, tax_rate, imported)
    total = base_price + base_price * tax_rate
    total += base_price * 0.1 if imported
    @charges << total
  end

  def total_charge
    @charges.inject(0) { |total, charge| total + charge }
  end
end

aount.add_charge(10, 0.2, true)
aount.add_charge(10, 0.2, false)
total = aount.total_charge

##### After #####

class Account
  def add_charge(charge)
    @charges << charge.total
  end

  def total_charge
    @charges.inject(0) { |total, charge| total + charge }
  end
end

class Charge
  attr_accessor :base_price, :tax_rate, :imported

  def initialize(base_price, tax_rate, imported)
    @base_price = base_price
    @tax_rate = tax_rate
    @imported = imported
  end

  def total
    result = @base_price + @base_price * @tax_rate
    result += @base_price * 0.1 if @imported
    result
  end
end
