# evalを実行時からパース時へ（move eval from runtime to parse time）
# メソッド定義の中でevalをつかうのではなく、メソッドを定義するときに使う

# Before
class Person
  def self.attr_with_default(options)
    options.each_pair do |attribute, default_value|
      define_method(attribute) do
        eval "@#{attribute} ||= #{default_value}"
      end
    end
  end

  attr_with_default :emails => [], :employee_number => "EmployeeNumberGenerator.next"
end

# After
class Person
  def self.attr_with_default(options)
    options.each_pair do |attribute, default_value|
      eval "
        def #{attribute}
          @#{attribute} ||= #{default_value}
        end
      "
    end
  end

  attr_with_default :emails => [], :employee_number => "EmployeeNumberGenerator.next"
end