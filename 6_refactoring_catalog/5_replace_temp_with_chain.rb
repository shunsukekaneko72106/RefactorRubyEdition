# 一時変数からチェインへ（Replace Temp with chain）
# チェイニングをサポートするようにメソッドを書き換え、一時変数を不要にする

###### Before ######
mock = Mock.new
expectation = mock.expects(:a_method_name)
expectation.with("arguments")
expectation.returns([1, :array])

###### After ######
mock = Mock.new
mock.expects(:a_method_name).with("arguments").returns([1, :array])

# メソッドの呼び出しのチェイニングを認めることによって、一つのオブジェクトの表現力を高めることができる

###### Before ######

class Select
  def options
    @options ||= []
  end

  def add_option(arg)
    options << arg
  end
end

select = Select.new
select.add_option(1999)
select.add_option(2000)
select.add_option(2001)
select.add_option(2002)

###### After ######

class Select
  def self.with_option(opton)
    select = self.new
    select.options << option
    select
  end

  def and(arg)
    options << arg
    self
  end
end

select = Select.with_option(1999).and(2000).and(2001).and(2002)

