# クラスアノテーションの導入（introduce class annotation）
# クラス定義からクラスメソッドを呼び出して振る舞いを宣言する

#### Before ####
class SearchCriteria
  
  def initialize(hash)
    @author_id = hash[:author_id]
    @publisher_id = hash[:publisher_id]
    @isbn = hash[:isbn]
  end
end

#### After ####
class SearchCriteria
  hash_initializer :author_id, :publisher_id, :isbn

end


#### Before ####
class SearchCriteria
  
  def initialize(hash)
    @author_id = hash[:author_id]
    @publisher_id = hash[:publisher_id]
    @isbn = hash[:isbn]
  end
end

#### After ####
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

Class.send(:include, CustomInitializers)
class SearchCriteria
  hash_initializer :author_id, :publisher_id, :isbn

end
