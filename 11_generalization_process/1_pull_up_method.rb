# メソッドの上位階層への移動
# メソッドをスーパークラスに移動する

##### Before #####
class Employee

end

class SalesPerson < Employee
  def name
    //...
  end
end

class Engineer < Employee
  def name
    //...
  end
end

##### After #####

class Employee
  def name
    //...
  end 
end

class SalesPerson < Employee

end

class Engineer < Employee

end