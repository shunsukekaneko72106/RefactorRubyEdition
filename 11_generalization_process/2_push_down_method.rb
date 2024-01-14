# メソッドの下位階層へ移動
# メソッドをサブクラスに移動する

##### Before #####
class Employee
  def quota
    //...
  end
end

class SalesPerson < Employee

end

class Engineer < Employee

end

##### After #####

class Employee
end

class SalesPerson < Employee
  def quota
    //...
  end
end

class Engineer < Employee

end