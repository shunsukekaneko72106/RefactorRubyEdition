# フィールドの移動（move_field）
# ターゲットクラスに新しい属性リーダー（必要ならライター）も作り、フィールドを持っているコードを書き換える

##### Before #####
class Account
  def interst_for_amount_days(amount, days)
    @interest_rate * amount * days / 365
  end
end

##### After #####

class AccountType
  atrr_accessor :interest_rate

end

class Account
  def interst_for_amount_days(amount, days)
    @account_type.interest_rate * amount * days / 365
  end
end


##### サンプル：「自己カプセル化フィールド」を使う #####

class Account
  attr_accessor :interest_rate

  def interst_for_amount_days(amount, days)
    interest_rate * amount * days / 365
  end

  def interest_rate
    @account_type.interest_rate
  end
end

extend Forwardable
def_delegators :@account_type, :interest_rate, :interest_rate=

def interst_for_amount_days(amount, days)
  interest_rate * amount * days / 365
end