# 引数への代入の除去（Remove Assignments to Parameters）
# コードが引数に代入をおこなっている
# 代入を削除し、代わりに一時変数を使用する

##### Before #####
def discount(input_val, quantity, year_to_date)
  if input_val > 50
    input_val -= 2
  end
end

##### After #####
def discount(input_val, quantity, year_to_date)
  result = input_val
  if input_val > 50
    result -= 2
  end
end

# 値渡しか参照渡しかで混乱が起き、わかりにくくなる

##### Before #####
def discount(input_val, quantity, year_to_date)
  input_val -= 2 if input_val > 50
  input_val -= 1 if quantity > 100
  input_val -= 4 if year_to_date > 10000
  input_val
end

##### After #####
def discount(input_val, quantity, year_to_date)
  result = input_val
  result -= 2 if input_val > 50
  result -= 1 if quantity > 100
  result -= 4 if year_to_date > 10000
  result
end
