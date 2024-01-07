# クラスのインライン化
# 全ての機能を他のクラスに移して、クラスを削除する

##### Before #####
class Person
  attr_reader :name

  def initialize
    @office_telephone = TelephoneNumber.new
  end

  def telephone_number
    @office_telephone.telephone_number
  end

  def office_telephone
    @office_telephone
  end
end 

class TelephoneNumber
  attr_accessor :area_code, :number

  def telephone_number
    "('area_code') #{number}"
  end
end

##### After #####
class Person
  def area_code
    @office_telephone.area_code
  end

  def area_code=(arg)
    @office_telephone.area_code = arg
  end

  def number
    @office_telephone.number
  end

  def number=(arg)
    @office_telephone.number = arg
  end
end


martin = Person.new
martin.office_telephone.area_code = "123"

# 下記のように書き換えられる
martin = Person.new
martin.area_code = "123"