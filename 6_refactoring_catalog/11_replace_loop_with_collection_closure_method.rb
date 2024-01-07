# ループからコレクションメソッドへ（replace loop with collection closure method）
# ループをコレクションメソッドに置き換える
# コードを短く、明快にすることができる


###### Before ######

manegers = []
people.each do |person|
  manegers << person if person.manager?
end

###### After ######
managers = people.select { |person| person.manager? }


###### Before ######
offices = []
employees.each { |e| offices << e.office }

###### After ######
offices = employees.collect { |e| e.office }


###### Before ######
manegerOffices = []
employees.each do |e|
  manegerOffices << e.office if e.manager?
end

###### After ######
manegerOffices = employees.select { |e| e.manager? }.collect { |e| e.office }


###### Before ######
total = 0
employees.each { |e| total += e.salary }

###### After ######
total = employees.inject(0) { |sum, e| sum + e.salary }