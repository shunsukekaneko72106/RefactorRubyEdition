# 引数から別々のメソッドへ

##### Before #####
def set_value(name, value)
  if name == "height"
    @height = value
  elsif name == "weight"
    @weight = value
  end
end

##### After #####
def set_height(value)
  @height = value
end

def set_weight(value)
  @weight = value
end

##### Before #####
ENGINEER = 0
SALESPERSON = 1
MANAGER = 2

def create(type, value)
  case type
  when ENGINEER
    Engineer.new(value)
  when SALESPERSON
    Salesperson.new(value)
  when MANAGER
    Manager.new(value)
  else
    raise ArgumentError.new("Incorrect type code value")
  end
end

##### After #####

def self.create_engnieer
  Engineer.new
end

def self.create_salesperson
  Salesperson.new
end

def self.create_manager
  Manager.new
end

def self.create(type)
  case type
  when ENGINEER
    create_engnieer
  when SALESPERSON
    create_salesperson
  when MANAGER
    create_manager
  else
    raise ArgumentError.new("Incorrect type code value")
  end
end