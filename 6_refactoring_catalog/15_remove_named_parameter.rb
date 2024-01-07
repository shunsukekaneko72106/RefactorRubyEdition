# 名前付き引数の除去（remove named parameter）
# 名前付き引数のハッシュを標準の引数リストに取り替える

##### Before #####

IsbnSearch.new(:isbn => "0201485672")

##### After #####

IsbnSearch.new("0201485672")

##### Before #####

Books.find
Books.find((:selecter => :all, 
            :conditions => "authors.name == 'jenny hames'",
            :joins => :authors,))
Books.find((:selecter => :first, 
            :conditions => "authors.name == 'jennyhames'",
            :joins => :authors,))

class Books
  def self.find(hash={})
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
    sql << "LIMIT 1" if hash[:selecter] == :first
    connection.fing(sql.join(" "))
  end
end

##### After #####
Books.find(:all)
Books.find((:all, 
            :conditions => "authors.name == 'jenny hames'",
            :joins => :authors,))
Books.find((:first, 
            :conditions => "authors.name == 'jennyhames'",
            :joins => :authors,))

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