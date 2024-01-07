# 属性初期化の遅延実行
# 構築時には初期化しないが、初めてアクセスされた時に初期化する

##### Before #####
class Employee
  def initialize
    @emails = []
  end
end

##### After #####
class Employee
  def emails
    @emails ||= []
  end
end