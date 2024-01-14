# モジュールの抽出
# 新しいモジュールを作成し、関連する振る舞いを古いクラスからモジュールに移し、それらのクラスでモジュールをincludeする

###### Before ######
class Bid
  before_save :capture_account_number

  def capture_account_number
    self.account_number = buyer.preferred_account_number
  end

end

##### After #####
class Bid
include AccountNumberCaptureable
end

module AccountNumberCaptureable
  def self.included(base)
    base.before_save :capture_account_number
  end

  def capture_account_number
    self.account_number = buyer.preferred_account_number
  end
end
