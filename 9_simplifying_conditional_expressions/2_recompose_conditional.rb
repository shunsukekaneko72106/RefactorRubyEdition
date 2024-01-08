# 条件分岐の組み替え
# 条件分岐コードを取り除き、Rubyらしい構文要素を使ったコードに置き換える

##### Before #####
parameters = params ? params : []

##### After #####
parameters = params || []


##### Before #####
def reward_points
  if days_rented > 1
    2
  else
    1
  end
end

##### After #####
def reward_points
  return 2 if days_rented > 1
  1
end