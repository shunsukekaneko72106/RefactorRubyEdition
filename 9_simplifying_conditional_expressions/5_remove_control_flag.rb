# 制御フラグの除去
# 一連の理論式で使われる制御フラグとして機能している変数がある場合は、代わりにbreakやreturnを使う

##### Before（単純な制御フラグをbreakに） #####
def check_security(people)
  found = false
  people.each do |person|
    unless found
      if person == "Don"
        send_alert
        found = true
      end
      if person == "John"
        send_alert
        found = true
      end
    end
  end
end

##### After #####
def check_security(people)
  people.each do |person|
    if person == "Don"
      send_alert
      break
    end
    if person == "John"
      send_alert
      break
    end
  end
end

##### Before（制御フラグの結果情報を返すreturn） #####
def check_security(people)
  found = ""
  people.each do |person|
    if found == ""
      if person == "Don"
        send_alert
        found = "Don"
      end
      if person == "John"
        send_alert
        found = "John"
      end
    end
  end
  some_later_code(found)
end

##### After #####

def check_security(people)
  found = found_miscreant(people)
  some_later_code(found)
end

def found_miscreant(people)
  people.each do |person|
    if person == "Don"
      send_alert
      return "Don"
    end

    if person == "John"
      send_alert
      return "John"
    end
  end
  ""
end






