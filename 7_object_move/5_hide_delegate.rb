# 委譲の隠蔽（Hide Delegate）
# サーバに委譲を隠すためのメソッドを作成

##### Before #####
class Person
  attr_accessor :department
end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end
end

manager = john.department.manager

##### After #####
class Person
  extend Forwardable
  def_delegator :@department, :manager

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