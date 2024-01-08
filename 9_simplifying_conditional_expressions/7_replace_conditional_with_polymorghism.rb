# 条件分岐からポリモーフィズムへ
# 条件式の分岐先をポリモーフィックに呼び出せるオブジェクトのメソッドに移す

###### Before ######
class MountainBike
  def price
    case @type_code
    when :rigid
      (1 + @commission) * @base_price
    when :front_suspension
      (1 + @commission) * @base_price + @front_suspension_price
    when :full_suspension
      (1 + @commission) * @base_price + @front_suspension_price + @rear_suspension_price
    end
  end
end

###### After ######

class RifidMountainBike
include MountainBike

  def price
    (1 + @commission) * @base_price
  end
end

class FrontSuspensionMountainBike
include MountainBike

  def price
    (1 + @commission) * @base_price + @front_suspension_price
  end

class FullSuspensionMountainBike
include MountainBike

  def price
    (1 + @commission) * @base_price + @front_suspension_price + @rear_suspension_price
  end

end
