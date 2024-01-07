# サンドイッチメソッドの抽出（Extract Surrounding Method）
# 重複部分を抽出して、ブロック付きのメソッドにする。この種のメソッドは、呼び出し元に一時的に制御を返してくる
# 呼び出し元は、制御を返されたときに実行するコードをブロックないに記述する

#### Before ####
def charge(amount, credit_card_number)
  begin
    connection = CreditCardServer.connect(...)
    connection.send(amount, credit_card_number)
  rescue IOError => e
    Logger.log "Could not submit order #{@order_number} to the server: #{e}"
    return nil
  ensure
    connection.close
  end
end

#### After ####
def charge(amount, credit_card_number)
  connect do |connection|
    collection.send(amount, credit_card_number)
  end
end

def connect
  begin
    connection = CreditCardServer.connect(...)
    yield connection
  rescue IOError => e
    Logger.log "Could not submit order #{@order_number} to the server: #{e}"
    return nil
  ensure
    collection.close
  end
end



#### Before ####
class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death = nil, mother = nil)
    @name, @mother = name, mother
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  # 生きている子供の数を返す
  def number_of_living_descendants
    children.inject(0) do | count, child |
      count += 1 if child.alive?
      count + child.number_of_living_descendants
    end
  end

  # 特定の名前を持つ子孫の数を返す
  def number_of_descendants_named(name)
    children.inject(0) do | count, child |
      count += if child.name == name
      count + child.number_of_descendants_named(name)
    end
  end

  def alive?
    @date_of_death.nil?
  end
end

#### After ####
class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death = nil, mother = nil)
    @name, @mother = name, mother
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def alive?
    @date_of_death.nil?
  end

  def number_of_descendants_named(name)
    count_descendants_matching(name) { |descendant| descendant.name == name }
  end


  def count_descendants_matching(&block)
    children.inject(0) do | count, child |
      count += 1 if yield child
      count + child.count_descendants_matching(&block)
    end
  end

  def number_of_living_descendants
    count_descendants_matching { |descendant| descendant.alive? }
  end
end

