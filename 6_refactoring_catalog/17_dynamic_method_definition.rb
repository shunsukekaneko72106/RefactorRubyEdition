# 動的メソッド定期（dynamic method definition）
# メソッドを動的に定義する

##### Before #####

def failure
  self.state = :failure
end

def error
  self.state = :error
end

##### After #####
def_each(:failure, :error) do |name|
  self.state = name
end


##### Before #####

def failure
  self.state = :failure
end

def error
  self.state = :error
end

def success
  self.state = :success
end

##### After #####

def_each(:failure, :error, :success) do |name|
  self.state = name
end

# サンプル：クラスアノテーションによるインスタンスメソッドの定義
class Post
  def self.states(*args)
    args.each do |arg|
      define_method(arg) do
        self.state = arg
      end
    end

    states :failure, :error, :success
  end
end


# サンプル：動的に定義されたモジュールをextendしてメソッドを定義する

class PostData
  def initialize(post_data)
    @post_data = post_data
  end

  def params
    @post_data[:params]
  end

  def session
    @post_data[:session]
  end

end

class Hash
  def to_module
    hash = self
    Module.new do
      hash.each do |key, value|
        define_method(key) do
          value
        end
      end
    end
  end
end

# Hashクラスがあれば、PostDataクラスは次のように書き換えられる
class PostData
  def initialize(post_data)
    self.extend(post_data.to_module)
  end
end

































