# 問い合わせと更新を分離する

##### Before #####
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

def check_security(people)
  found = found_miscreant(people)
  some_later_code(found)
end

##### After #####
def found_person(people)
  people.each do |person|
    return "Don" if person == "Don"
    return "John" if person == "John"
  end
  ""
end

def send_alert_if_miscreant_in(people)
  send_alert unless found_person(people).empty?
end

def check_security(people)
  send_alert_if_miscreant_in(people)
  some_later_code(found)
end

