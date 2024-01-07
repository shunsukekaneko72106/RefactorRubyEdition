# 属性初期化の先行実行
# 最初にアクセスされた時ではなく、構築時に属性を初期化する

##### Before #####
class Employee
  def emails
    @emails ||= []
  end
end

##### After #####
class Employee
  def initialize
    @emails = []
  end
end