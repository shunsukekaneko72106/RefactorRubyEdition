# 配列からオブジェクトへ（replace array with object）
# 配列を取り除き、各要素をフィールドとするオブジェクトを定義する

# Before
row = []
row[0] = "Liverpool"
row[1] = "15"

# After
row = Performance.new
row.name = "Liverpool"
row.wins = "15"

# サンプル
# Before  

row = []
row[0] = "Liverpool"
row[1] = "15"

name = row[0]
wins = row[1].to_i

# After

class Performance

  attr_accessor :name
  attr_writer :wins

  def initialize
    @data = []
  end

  def wins
    @wins.to_i
  end
end

row = Performance.new
row.name = "Liverpool"
row.wins = "15"
