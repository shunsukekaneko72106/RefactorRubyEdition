# 一時変数の分割（Split Temporary Variable）
# 代入ごとに別々の一時変数を用意する
# 複数の仕事を持つ一時変数がある場合には、仕事ごとに一時変数が１つずつあるべきだ。２つの異なる目的のために同じ変数を使うのは、読み手にとって混乱を招く。

##### Before #####
temp = 2 * (@height + @width)
puts temp
temp = @height * @width
puts temp

##### After #####
perimeter = 2 * (@height + @width)
puts perimeter
area = @height * @width
puts area

##### Before #####
def distance_traveled(time)
  acc = @primary_force / @mass
  primary_time = [time, @delay].min
  result = 0.5 * acc * primary_time * primary_time
  secondary_time = time - @delay
  if(secondary_time > 0)
    primary_vel = acc * @delay
    acc = (@primary_force + @secondary_force) / @mass
    result += primary_vel * secondary_time + 5 * acc * secondary_time * secondary_time
  end
  result
end

##### After #####

def distance_traveled(time)
  primary_acc = @primary_force / @mass
  primary_time = [time, @delay].min
  result = 0.5 * primary_acc * primary_time * primary_time
  secondary_time = time - @delay
  if(secondary_time > 0)
    primary_vel = primary_acc * @delay
    secondary_acc = (@primary_force + @secondary_force) / @mass
    result += primary_vel * secondary_time + 5 * secondary_acc * secondary_time * secondary_time
  end
  result
end


