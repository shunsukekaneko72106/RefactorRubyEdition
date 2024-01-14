# モジュールのインライン化
# モジュールをインクルードしているクラスにモジュールを統合する

##### Before(ChatGTPより提供) #####
module Greeting
  def greet
    "Hello, #{name}!"
  end
end

class Person
  include Greeting

  attr_reader :name

  def initialize(name)
    @name = name
  end
end


##### After #####
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    "Hello, #{name}!"
  end
end
