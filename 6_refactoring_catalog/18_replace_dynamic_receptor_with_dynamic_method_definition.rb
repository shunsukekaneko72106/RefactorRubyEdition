# 動的レセプタから動的メソッド定義へ(Replace Dynamic Receptor with Dynamic Method Definition)
# 動的メソッド定義を使って必要なメソッドを定義する

# サンプル：method_missingを使わない動的な委譲
# Before
class Decorator
  def initialize(subject)
    @subject = subject
  end

  def method_missing(sym, *args, &block)
    @subject.send(sym, *args, &block)
  end
end

# After
class Decorator
  def initialize(subject)
    subject.public_methods(false).each do |meth|
      (class << self; self; end).class_eval do
        define_method(meth) do |*args, &block|
          @subject.send(meth, *args, &block)
        end
      end
    end
  end
end

# サンプル：ユーザー定義データを使ってメソッドを定義する
# Before
class Person
  attr_accessor :name, :age
  
  def method_missing(sym, *args, &block)
    empty?(sym.to_s.sub(/^empty_/, "").chop)
  end

  def empty?(sym)
    self.send(sym).nil?
  end
end

# After

class Person
  def self.attrs_with_empty_predicate(*args)
    attr_accessor(*args)

    args.each do |attribute|
      define_method("empty_#{attribute}?") do
        self.send(attribute).nil?
      end
    end

    attrs_with_empty_predicate :name, :age  
  end
end



