# 設定メソッドの削除
# そのフィールドに対する設定メソッドを全て削除する

##### Before #####
class Account

  def initialize(id)
    self.id = id
  end
end


##### After #####

class Account

  def id=(value)
    @id = value
  end
end