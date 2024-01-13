# 例外からテストへ
# 呼び出し元がまずテストするように書き換える

##### Before #####
def excute(command)
  command.prepare rescue nil
  command.execute
end

##### After #####
def excute(command)
  command.prepare if command.respond_to?(:prepare)
  command.execute
end

