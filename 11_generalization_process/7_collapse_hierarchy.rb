# 階層構造の統合
# スーパークラスとサブクラス（またはモジュールとそのモジュールをインクルードするクラス）に大差がない。両者を一つに統合する

##### Before #####
class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def start_engine
    "Engine started!"
  end
end

class Car < Vehicle
  def open_trunk
    "Trunk opened!"
  end
end


##### After #####
class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def start_engine
    "Engine started!"
  end

  def open_trunk
    "Trunk opened!"
  end
end
