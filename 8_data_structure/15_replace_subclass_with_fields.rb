# サブクラスからフィールドへ
# メソッドをスーパークラスのフィールドに変えて、サブクラスを削除する


##### Before #####
class Person

end

class Femal < Person

  def femal?
    true
  end

  def code
    'F'
  end
end

class Male < Person

  def femal?
    false
  end

  def code
    'M'
  end
end


##### After #####
class Person

  def initialize(female, code)
    @femal = female
    @code = code
  end

  end
  def self.create_femal
    Femal.new
  end

  def self.create_male
    Male.new
  end
end

class Femal
  def initialize
    super(true, 'F')
  end
end

class Male
  def initialize
    super(false, 'M')
  end
end

