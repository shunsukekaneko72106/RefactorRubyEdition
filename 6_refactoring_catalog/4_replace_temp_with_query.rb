# 一時変数から問い合わせメソッドへ
# 式をメソッドにする。一時変数のすべての参照箇所を式に置き換える。新しいメソッドは他のメソッドからも使える

##### before #####

base_price = @quantity * @item_price

if(base_price > 1000)
  base_price * 0.95
else
  base_price * 0.98
end

##### after #####

if(base_price > 1000)
  base_price * 0.95
else
  base_price * 0.98
end

def base_price
  @quantity * @item_price
end

# このリファクタリングが簡単に使えるのは、一時変数が一度しか代入されず、代入される値を生成する式に副作用がないときだけ

##### before #####

def price
  base_price = @quantity * @item_price
  if(base_price > 1000)
    discount_factor = 0.95
  else
    discount_factor = 0.98
  end
  base_price * discount_factor
end

##### after #####

def price
  base_price * discount_factor
end

def base_price
  @quantity * @item_price
end

def discount_factor
  base_price > 1000 ? 0.95 : 0.98
end