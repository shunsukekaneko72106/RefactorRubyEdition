# メソッドのインライン化（Inline method）
# メソッドの本体を呼び出しもとの本体に組み込み、メソッドを削除する

##### 例 #####
def get_rating
  more_than_five_late_deliveries ? 2 : 1
end

def more_than_five_late_deliveries
  @number_of_late_deliveries > 5
end

#### 修正後 ####

def get_rating
  @number_of_late_deliveries > 5 ? 2 : 1
end

# 間接化が過ぎて、メソッドの存在意義がなくなってしまった場合は、メソッドをインライン化する