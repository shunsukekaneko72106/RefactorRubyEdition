# nullオブジェクトの導入
# nilの代わりにnullオブジェクトを導入する

class Site
  attr_reader :customer

end

class Customer
  attr_reader :name, :plan, :history

end


class PaymentHistory
  def weeks_delinquent_in_last_year

  end

end

customer = site.customer
plan = customer ? customer.plan : BillingPlan.basic
customer_name = customer ? customer.name : 'occupant'
weeks_delinquent = customer.nil? ? 0 : customer.history.weeks_delinquent_in_last_year

# ↓

class MissingCustomer
  def missing? ; true; end
  # ...
end

class Customer
  def missing?; false; end
  # ...
end

class NullCustomer
  def name
    'occupant'
  end
  # ...
end

# 使用例（前提: site.customer が NullCustomer インスタンスを返す場合）
customer = site.customer
plan = customer.missing? ? BillingPlan.basic : customer.plan
customer_name = customer.name
weeks_delinquent = customer.missing? ? 0 : customer.history.weeks_delinquent_in_last_year
