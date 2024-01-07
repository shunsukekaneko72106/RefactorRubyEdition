# タイプコードからモジュールのextendへ
# タイプコードを動的なモジュールのextendに置き換える

##### Before #####
class MountainBike

  attr_writer :type_code

  def initialize(params)
    @type_code = params[:type_code]
    @commission = params[:commission]
  end

  def off_road_ability
    result = @tire_width * TIRE_WIDTH_FACTOR
    if @type_code == :front_suspension || @type_code == :full_suspension
      result += @front_fork_travel * FRONT_SUSPENSION_FACTOR
    end
    if @type_code == :full_suspension
      result += @rear_fork_travel * REAR_SUSPENSION_FACTOR
    end
    result
  end

  def price
    case @type_code
      when :rigid
        (1 + @commission) * @base_price
      when
        (1 + @commission) * @base_price + @front_suspension_price
      when :full_suspension
        (1 + @commission) * @base_price + @front_suspension_price + @rear_suspension_price
    end
  end
end

bike = MountainBike.new(:type_code => :rigid)
bike.type_code = :front_suspension

##### After #####
class MountainBike

  attr_reader :type_code

  def initialize(params)
    @type_code = params[:type_code]
    @commission = params[:commission]

  end

  def type_code=(mod)
    extend(mod)
  end

  def off_road_ability
    @tire_width * TIRE_WIDTH_FACTOR
  end

  def price
    (1 + @commission) * @base_price + @front_suspension_price
  end
end

module FrontSuspensionMountainBike
  def price
    (1 + @commission) * @base_price + @front_suspension_price
  end

  def off_road_ability
    @tire_width * TIRE_WIDTH_FACTOR + @front_fork_travel * FRONT_SUSPENSION_FACTOR
  end
end

module FullSuspensionMountainBike
  def price 
    (1 + @commission) * @base_price + @front_suspension_price + @rear_suspension_price
  end

  def off_road_ability
    @tire_width * TIRE_WIDTH_FACTOR + @front_fork_travel * FRONT_SUSPENSION_FACTOR + @rear_fork_travel * FRONT_SUSPENSION_FACTOR
  end
end

bike = MountainBike.new
bike.type_code = FrontSuspensionMountainBike

