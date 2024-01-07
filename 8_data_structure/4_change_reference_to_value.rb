# 参照から値へ（ Change Reference to Value ）
# そのオブジェクトを値オブジェクトに変更する

###### Before #####
class Currency
  attr_reader :code

  def initialize(code)
    @code = code
  end
end

##### After #####
class Currency
  def eql?(other)
    self == other
  end

  def ==(other)
    other.equal?(self) || (other.instance_of?(self.class) && other.code == code)
  end

  def hash
    code.hash
  end
end

