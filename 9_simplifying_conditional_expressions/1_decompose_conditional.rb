# 条件式の分解
# 条件部、then節、else節からメソッドを抽出する

##### Before #####
if date < SUMMER_START || date > SUMMER_END
  charge = quantity * @winter_rate + @winter_service_charge
else
  charge = quantity * @summer_rate
end

##### After #####
if not_summer(date)
  charge = winter_charge(quantity)
else
  charge = summer_charge(quantity)
end


def not_summer(date)
  date < SUMMER_START || date > SUMMER_END
end

def winter_charge(quantity)
  quantity * @winter_rate + @winter_service_charge
end

def summer_charge(quantity)
  quantity * @summer_rate
end