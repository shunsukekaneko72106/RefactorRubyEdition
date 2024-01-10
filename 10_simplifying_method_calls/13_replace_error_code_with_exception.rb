# エラーコードから例外へ

##### Before #####

def withdrow(amount)
  return -1 if amount > @balance
  @balance -= amount
  0
end

##### After #####

def withdrow(amount)
  raise BalanceError.new if amount > @balance
  @balance -= amount
end


##### After（呼び出し元が呼び出し前にエラー条件をチェックする） #####

class Account
  include Assertions

  def withdrow(amount)
    assert("amount too large") { amount <= @balance }
    @balance -= amount
  end

end

class Assertions
  class AssertionFailedError < StandardError; end

  def assert(message, &condition)
    unless condition.call
      raise AssertionFailedError.new("Assertion Failed: #{message}")
    end
  end
end


##### After（呼び出し元が例外をキャッチする） #####
def new_withdraw(amount)
  raise BalanceError.new if amount > @balance
  @balance -= amount
end


def withdrow(amount)
  begin
    account.new_withdraw(amount)
    do_the_usual_thing
  rescue BalanceError
    handle_overdrawn
  end
end

