# アルゴリズム変更（substitute algorithm）
# メソッド本体を新しいアルゴリズムに置き換える

##### Before #####
def found_person(people)
  friends = []
  people.each do |person|
    if person == "Don"
      friend << "Don"
    end
    if person == "John"
      friend << "John"
    end
    if person == "Kent"
      friend << "Kent"
    end
  end
  friends
end

##### After #####

def found_person(people)
  people.select do |person|
    ["Don", "John", "Kent"].include?(person)
  end
end