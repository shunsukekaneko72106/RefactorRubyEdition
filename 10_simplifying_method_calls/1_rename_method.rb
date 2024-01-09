# メソッド名変更

def telephone_number
  "(#{@office_area_code}) #{@office_number}"
end

class Person
  def telephone_number
    office_telephone_number
  end

  def office_telephone_number
    "(#{@office_area_code}) #{@office_number}"
  end
end