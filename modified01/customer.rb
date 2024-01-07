# 店の顧客を表す。他のクラス同様に、データとアクセッサ（属性アクセス用メソッド）を持つ。
class Customer 

  attr_reader :name
  
  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  #statemetは領収書を印刷するためのメソッド
  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do | element |

      #このレンタルの料金を表示
      result = "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    end

    # フッター行を追加
    result += "Amount owed is #{total_charge}\n"
    result += "You earned #{total_frequent_renter_points} frequent renter points"
  end

  private

  def total_charge
    @rentals.inject(0) { |sum, element| sum + element.charge }
  end

  def total_frequent_renter_points
    @rentals.inject(0) { |sum, element| sum + element.frequent_renter_points }
  end
end

