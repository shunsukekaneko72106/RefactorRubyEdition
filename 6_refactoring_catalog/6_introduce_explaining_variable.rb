# 説明用変数の導入(Introduce Explaining Variable)
# 処理の目的を説明するような名前を持つ一時変数に式、または式の一部を代入する

##### Before #####
if(platform.upcase.index("MAC") > -1 && browser.upcase.index("IE") > -1 && wasInitialized() && resize > 0)
  # do something
end

##### After #####
is_mac_os = platform.upcase.index("MAC") > -1
is_ie_browser = browser.upcase.index("IE") > -1
was_resized = resize > 0
if(is_mac_os && is_ie_browser && wasInitialized() && was_resized)
  # do something
end 

##### Before #####
def price
  # 価格は基本価格 - 数量割引 + 配送料
  return @quantity * @item_price - [0, @quantity - 500].max * @item_price * 0.05 + [@quantity * @item_price * 0.1, 100.0].min
end

##### After #####
def price
  # 価格は基本価格 - 数量割引 + 配送料
  base_price = @quantity * @item_price
  quantity_discount = [0, @quantity - 500].max * @item_price * 0.05
  shipping = [base_price * 0.1, 100.0].min
  return base_price - quantity_discount + shipping
end

##### After（メソッドを使った例） #####
def price
  base_price - quantity_discount + shipping
end

def base_price
  @quantity * @item_price
end

def quantity_discount
  [0, @quantity - 500].max * @item_price * 0.05
end
