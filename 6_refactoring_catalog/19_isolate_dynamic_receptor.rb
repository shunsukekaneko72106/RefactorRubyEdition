# 動的レセプタの分離（Dynamic Receptor Isolation）
# 新しいクラスを導入し、method_missingのロジックをそのクラスに移動する

#### サンプルコード ####

class Recorder
  instance_methods.each do |meth|
    undef_method meth unless meth =~ /^(__|inspect)/
  end

  def initialize
    @messages = []
  end

  def method_missing(sym, *args, &block)
    @messages << [sym, args]
    self
  end

  def play_for(obj)
    @messages.inject(obj) do |result, message|
      result.send(message.first, *message.last)
    end
  end

  def to_s
    @messages.inject([]) do |result, message|
      result << "#{message.first}(args: #{message.last.inspect})"
    end.join(".")
  end
end

class CommandCenter
  def start(command_string)
    "Starting #{command_string}"
    self
  end

  def stop(command_string)
    "Stopping #{command_string}"
    self
  end
end

recorder = Recorder.new
recorder.start("LR")
recorder.stop("LR")
recorder.play_for(CommandCenter.new)

##### After #####

class MessageColector
  instance_methods.each do |meth|
    undef_method meth unless meth =~ /^(__|inspect)/
  end

  def messages
    @messages ||= []
  end

  def method_missing(sym, *args, &block)
    @messages << [sym, args]
    self
  end

end

class Recorder
  def play_for(obj)
    @message_collector.messages.inject(obj) do |result, message|
      result.send(message.first, *message.last)
    end
  end

  def record
    @message_collector ||= MessageColector.new
  end

  def to_s
    @message_collector.messages.inject([]) do |result, message|
      result << "#{message.first}(args: #{message.last.inspect})"
    end.join(".")
  end
end

recorder = Recorder.new
recorder.record.start("LR")
recorder.record.stop("LR")
recorder.play_for(CommandCenter.new)

