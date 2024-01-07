# クラスの抽出（Extract Class）
# 新しいクラスを作成し、関連フィールド、メソッドを旧クラスから新クラスに移す


##### Before #####
class Person
  attr_reader :name 
  attr_accessor :office_area_code, :office_number

  def telephone_number
    "(#{office_area_code}) #{office_number}"
  end
end


##### After #####
class TelephoneNumber
  attr_accessor :area_code, :number

  def telephone_number
    "(#{area_code}) #{number}"
  end
end

class Person
  attr_reader :name

  def initialize
    @office_telephone = TelephoneNumber.new
  end

  def telephone_number
    @office_telephone.telephone_number
  end

  def office_telephone_number
    @office_telephone.number
  end

  def office_area_code
    @office_telephone.area_code
  end

  def office_area_code=(arg)
    @office_telephone.area_code = arg
  end
end




