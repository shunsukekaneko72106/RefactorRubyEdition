# 重複する条件分岐の断片の統合
# 条件式のすべての分岐に同じコード片が含まれている。その部分を式の外に出す。

##### Before #####
if special_deal?
  total = price * 0.95
  send_order
else
  total = price * 0.98
  send_order
end

##### After #####
if special_deal?
  total = price * 0.95
else
  total = price * 0.98
end
send_order

