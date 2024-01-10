# メソッドの隠蔽
# メソッドを非公開にする

##### Before（ChatGTPより提供） #####
class User
  def initialize(name)
    @name = name
  end

  def display_name
    format_name
  end

  # このメソッドは外部からもアクセス可能
  def format_name
    @name.upcase
  end
end

user = User.new("alice")
puts user.format_name  # "ALICE" と表示


##### After #####

class User
  def initialize(name)
    @name = name
  end

  def display_name
    format_name
  end

  private

  # このメソッドは内部でのみ使用される
  def format_name
    @name.upcase
  end
end

user = User.new("alice")
puts user.display_name  # "ALICE" と表示
# puts user.format_name  # エラーが発生する
