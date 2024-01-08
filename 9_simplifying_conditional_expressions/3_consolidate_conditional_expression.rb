# 条件式の結合
# 同じ結果になる条件式がある場合は、それらを一つの条件式にまとめて、メソッドとして抽出する

##### Before #####
def disability_amount
  return 0 if @seniority < 2
  return 0 if @months_disabled < 12
  return 0 if @is_part_time

  # 本来の処理
end

##### After #####
def disability_amount
  return 0 if ineligible_for_disability?

  # 本来の処理
end

def ineligible_for_disability?
  @seniority < 2 || @months_disabled < 12 || @is_part_time
end

##### Before（ANDによる結合） #####
if on_vacation?
  if length_of_service > 10
    return 1
  end
end
0.5

##### After #####
return 1 if on_vacation? && length_of_service > 10
0.5
