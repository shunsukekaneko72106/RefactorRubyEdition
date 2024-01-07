# ハッシュからオブジェクトへ
# Hashを使っている場合は、オブジェクトに置き換える

##### Before #####
new_network = { :nodes => [], :old_network => [] }

new_network[:old_network] << node.network
new_network[:nodes] << node

new_network[:name] = new_network[:old_network].collect do | network |
  network.name
end.join(" - ")

##### After #####
net_work = NetworkResult.new
net_work.old_network << node.network
net_work.nodes << node

net_work.name = net_work.old_network.collect do | network |
  network.name
end.join(" - ")

##### After(サンプル) #####

new_network = NetworkResult.new
new_network.old_network << node.network
new_network.nodes << node

new_network[:name] = new_network.old_network.collect do | network |
  network.name
end.join(" - ")

class NetworkResult

  attr_reader :old_network, :nodes

  def initialize
    @old_network, @nodes = [], []
  end

  def name
    @old_network.collect{ | network | network.name }.join(" - ")
  end

  # def [](attribute)
  #   instance_variable_get("@#{attribute}")
  # end

  # def []=(attribute, value)
  #   instance_variable_set("@#{attribute}", value)
  # end


end