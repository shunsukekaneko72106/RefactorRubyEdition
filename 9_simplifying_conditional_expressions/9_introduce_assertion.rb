# アサーションの導入
# アサーションによって、前提条件を明確にすることができる

##### Before #####
def expense_limit
  # 支出の上限か担当プロジェクトが必要
  (expense_limit != NULL_EXPENSE) ? expense_limit : primary_project.member_expense_limit
end

##### After #####
def expense_limit
  assert @expense_limit != NULL_EXPENSE || primary_project
  (expense_limit != NULL_EXPENSE) ? expense_limit : primary_project.member_expense_limit
end