# 継承の導入
# 片方のクラスをスーパークラスにして、共通するメンバをスーパークラスに移動する

##### Before #####

class MountainBike
  TIRE_WIDTH_FACTOR = 6

  attr_reader :tire_diameter

  def wheel_circumference
    Math::PI * (@wheel_diameter + @tire_diameter)
  end

  def off_road_ability
    @tire_diameter * TIRE_WIDTH_FACTOR
  end
end

class FrontSuspensionMountainBike

  TIRE_WIDTH_FACTOR = 6
  FRONT_SUSPENSION_FACTOR = 8

  attr_reader :tire_diameter, :front_fork_travel

  def wheel_circumference
    Math::PI * (@wheel_diameter + @tire_diameter)
  end

  def off_road_ability
    @tire_diameter * TIRE_WIDTH_FACTOR + @front_fork_travel * FRONT_SUSPENSION_FACTOR
  end

end


##### After #####
class MountainBike
  TIRE_WIDTH_FACTOR = 6

  attr_reader :tire_diameter

  def wheel_circumference
    Math::PI * (@wheel_diameter + @tire_diameter)
  end

  def off_road_ability
    @tire_diameter * TIRE_WIDTH_FACTOR
  end
end

class FrontSuspensionMountainBike < MountainBike

  FRONT_SUSPENSION_FACTOR = 8

  attr_reader  :front_fork_travel


  def off_road_ability
    super + @front_fork_travel * FRONT_SUSPENSION_FACTOR
  end

end

