# 名前付き引数の導入（Introduce Named Parameter）
# 引数リストをハッシュに変換し、ハッシュキーを引数の名前として使う

##### Before #####
SearchCriteria.new(5, 8, "0140449116")

##### After #####
SearchCriteria.new(:author_id => 5, :publisher_id => 8, :isbn => "0140449116")

#### サンプル１ ####
# Before

class SearchCriteria
  attr_reader :author_id, :publisher_id, :isbn

  def initialize(author_id, publisher_id, isbn)
    @author_id = author_id
    @publisher_id = publisher_id
    @isbn = isbn
  end
end

criteria = SearchCriteria.new(5, 8, "0140449116")

# After（hash_initializerはあらゆるクラスで使えるようになる）
class SearchCriteria
  hash_initializer :author_id, :publisher_id, :isbn

end

module CustomInitializers
    def self.hash_initializer(*attribute_names)
      define_method(:initialize) do |*arg|
        data = args.first || {}
        attribute_names.each do |attribute_name|
          instance_variable_set("@#{attribute_name}", data[attribute_name])
        end
      end
    end
  end
end

#### サンプル２ ####
###### Before #####

class Books
  def self.find(selector, conditions="", *joins)
    sql = "SELECT * FROM books"
    joins.each do |join_table|
      sql << "LEFT OUTER JOIN #{join_table} ON"
      sql << "books.#{join_table.to_s.chop}_id"
      sql << " = #{join_table}.id"
    end
    sql << "WHERE #{conditions}" unless conditions.empty?
    sql << "LIMIT 1" if selector == :first
    connection.fing(sql.join(" "))
  end
end


##### After #####
# １つ目のメリット、メソッドに渡したキーの綴りを間違えたときにエラーをはくこと
# 2つ目のメリット、アサーションが必要な引数を読者にしらせる宣言文的役割を果たすこと

module AssertValidKeys
  def assert_valid_keys(*valid_keys)
    unknown_keys = keys - [valid_keys].flatten
    if unknown_keys.any?
      raise(ArgumentError, "Unknown key(s): #{unknown_keys.join(", ")}")
    end
  end
end

hash.send(:include, AssertValidKeys)

class Books
  def self.find(selector, hash={})
    hash.assert_valid_keys :conditions, :joins
    
    hash[:joins] ||= []
    hash[:conditions] ||= ""

    sql = "SELECT * FROM books"
    hash[:joins].each do |join_table|
      sql << "LEFT OUTER JOIN #{join_table} ON"
      sql << "books.#{join_table.to_s.chop}_id"
      sql << " = #{join_table}.id"
    end
    sql << "WHERE #{hash[:conditions]}" unless hash[:conditions].empty?
    sql << "LIMIT 1" if selector == :first
    connection.fing(sql.join(" "))
  end
end



