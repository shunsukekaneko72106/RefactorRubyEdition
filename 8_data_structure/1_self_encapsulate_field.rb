# 自己カプセル化フィールド（Self Encapsulate Field）
# フィールドのゲッターとセッターを作成し、フィールにアクセスするときにはそれらだけを使う

##### Before #####
def total
  @base_price * (1 + @tax_rate)
end

##### After #####
attr_reader :base_price, :tax_rate

def total
  base_price * (1 + tax_rate)
end


# 例
# Before
class Item
  def initialize(base_price, tax_rate)
    @base_price = base_price
    @tax_rate = tax_rate
  end

  def raise_base_price_by(percent)
    @base_price = @base_price * (1 + percent)
  end

  def total
    @base_price * (1 + @tax_rate)
  end
end

# After
class Item
  attr_accessor :base_price, :tax_rate

  def raise_base_price_by(percent)
    @base_price = @base_price * (1 + percent)
  end

  def total
    base_price * (1 + tax_rate)
  end
end

class ImportedItem < Item
  attr_accessor :import_duty

  def initialize(base_price, tax_rate, import_duty)
    super(base_price, tax_rate)
    @import_duty = import_duty
  end

  def tax_rate
    super + import_duty
  end
end


