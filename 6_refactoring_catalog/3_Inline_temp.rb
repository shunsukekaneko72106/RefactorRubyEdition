# 一時変数のインライン化
# その一時変数に対するすべての参照を取り除き、しきにする

###### 例 ######
base_price = an_order.base_price
return (base_price > 1000)

##### 修正後 #####
return (an_order.base_price > 1000)

# 一時変数のインライン化は、メソッドの呼び出しの戻り値が一時変数に代入されている場合に使える