# 横流しブローカーの除去（Remove Middle Man）
# クライアントに委譲しているメソッドを、サーバーに直接委譲するようにする

# Before
class Person
  attr_accessor :department
  
  def initialize(department)
    @department = department
  end

  def manager
    @department.manager
  end
end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end
end

manager = john.department.manager

# After
class Person
  def manager
    @department.manager
  end
end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end
end

manager = john.manager