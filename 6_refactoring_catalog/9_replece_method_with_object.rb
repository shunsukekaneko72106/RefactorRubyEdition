# メソッドからメソッドオブジェクトへ（replace method with method object）
# メソッドを独自のオブジェクトに変え、すべてのローカル変数がそのオブジェクトのインスタンス変数になるようにする
# メソッドを分解して、同じオブジェクトの別のメソッドにすることが可能になる

###### Before ######
class Account
  def gamma(input_val, quantity, year_to_date)
    important_value1 = (input_val * quantity) + delta
    important_value2 = (input_val * year_to_date) + 100
    if(year_to_date - important_value1 > 100)
      important_value2 -= 20
    end
    important_value3 = important_value2 * 7
    # and so on.
    important_value3 - 2 * important_value1
  end
end

###### After ######
class gamma
  attr_reader :account, 
              :input_val,
              :quantity, 
              :year_to_date, 
              :important_value1, 
              :important_value2, 
              :important_value3

  def initialize(account, input_val, quantity, year_to_date)
    @account = account
    @input_val = input_val
    @quantity = quantity
    @year_to_date = year_to_date
  end

  def compute
    @important_value1 = (input_val * quantity) + @account.delta
    @important_value2 = (input_val * year_to_date) + 100
    important_thing
    @important_value3 = important_value2 * 7
    # and so on.
    @important_value3 - 2 * important_value1
  end

  def important_thing
    if(year_to_date - important_value1 > 100)
      important_value2 -= 20
    end
  end
end

class Account

  def gamma(input_val, quantity, year_to_date)
    Gamma.new(self, input_val, quantity, year_to_date).compute
  end
end