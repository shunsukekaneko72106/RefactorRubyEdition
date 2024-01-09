# オブジェクト自体の受け渡し

##### Before ##### 
low = days_temp_range.low
high = days_temp_range.high
plan.within_range?(low, high)


##### After #####
plan.within_range?(days_temp_range)


##### Before #####
class HeatingPlan
  def within_range?(low, high)
    (low >= range.low) && (high <= range.high)
  end
end

class Room
  def within_plan?(plan)
    low = days_temp_range.low
    high = days_temp_range.high
    plan.within_range?(low, high)
  end
end

##### After #####
class HeatingPlan
  def with_temperature_range?(room_temperable_range)
    @range.includes?(room_temperable_range)
  end
end

class Room
  def within_plan?(plan)
    plan.within_range?(days_temp_range)
  end
end

class TempRange
  def includes?(temperature_range)
    temperature_range.low >= low && temperature_range.high <= high
  end
end

