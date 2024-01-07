# コレクションのカプセル化 (Encapsulate Collection) 
# メソッドにはコレクションのコピーを変えさせるようにして、add_やremove_などのメソッドを用意する

# Before

class Course
  def initialize(name, advanced)
    @name = name
    @advanced = advanced
  end
end

class Parson

end

# クライアントはこのインターフェースを使ってつぎのようにコースを追加する
kent = Parson.new
courses = []
courses << Course.new("Smalltalk Programming", false)
courses << Course.new("Appreciating Single Malts", true)
kent.courses = courses
assert_equal 2, kent.courses.size # 2つのコースがある（テストコード）
refactoring = Course.new("Refactoring", true)
kent.courses << refactoring
kent.courses << Course.new("Brutal Sarcasm", false)
assert_equal 4, kent.courses.size # 4つのコースがある（テストコード）
kent.courses.delete(refactoring)
assert_equal 3, kent.courses.size # 3つのコースがある（テストコード）

#上級講座（advanced）について知りたいクライアントはつぎのようにする
parson.courses.select){ |course| course.advanced? }.size

# After
class Parson
  def initialize
    @courses = []
  end

  def add_course(course)
    @courses << course
  end

  def remove_course(course)
    @courses.delete(course)
  end

  def initialize_courses(courses)
    raise "Courses should be empty" unless @courses.empty?
    @courses += courses
  end

  def courses
    @courses.dup
  end
end

kent = Parson.new
kent.add_course(Course.new("Smalltalk Programming", false))
kent.add_course(Course.new("Appreciating Single Malts", true))
kent.initialize_courses(courses)