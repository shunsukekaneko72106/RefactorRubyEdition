# ゲートウェイの導入
# 外部システムやリソースへのアクセスをカプセル化するゲートウェイを導入する

###### Before #####
class Preson
  attr_accessor :first_name, :last_name, :ssn

  def save
    url = URL.parse("http://www.example.com/person")
    request = Net::HTTP::Post.new(url.path)
    request.set_form_data({
      'first_name' => first_name,
      'last_name' => last_name,
      'ssn' => ssn
    })
    Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
  end
end


class Company
  attr_accessor :name, :tax_id

  def save
    url = URL.parse("http://www.example.com/companies")
    request = Net::HTTP::Get.new(url.path + "?name=#{name}&tax_id=#{tax_id}")
    Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
  end
end

class Laptop
  attr_accessor :assiged_to, :serial_number

  def save
    url = URL.parse("http://www.example.com/issued_laptops")
    request = Net::HTTP::Post.new(url.path)
    request.basic_auth 'username', 'password'
    request.set_form_data({
      'assigned_to' => assigned_to,
      'serial_number' => serial_number
    })
    Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
  end
end

###### After #####

class Gateway
  attr_accessor :subject, :attributes, :to, :authenticate

  def self.save
    gateway = self.new
    yield gateway
    gateway.execute
  end

  def execute
    request = build_request
    request.basic_auth 'username', 'password' if authenticate
    Net::HTTP.new(url.host, url.port).start {|http| http.request(request)}
  end

  def url
    URL.parse(to)
  end
end

class PostGateway < Gateway
  def build_request
    request = Net::HTTP::Post.new(url.path)
    attribute_hash = attributes.inject({}) do |result, attribute|
      result[attrbute.to_s] = subject.send attribute
      result
    end
    request.set_form_data(attribute_hash)
  end
end

class GetGateway < Gateway
  def build_request
    parameters = attributes.collect do |attribute|
      "#{attribute}=#{subject.send(attribute)}"
    end
    Net::HTTP::Get.new(url.path + "?" + parameters.join("&"))
  end
end


class Company
  attr_accessor :name, :tax_id

  def save
    GetGateway.save do |persist|
      persist.subject = self
      persist.attributes = [:name, :tax_id]
      persist.to = "http://www.example.com/companies"
    end
  end
end


class Preson
  attr_accessor :first_name, :last_name, :ssn

  def save
    PostGateway.save do |persist|
      persist.subject = self
      persist.attributes = [:first_name, :last_name, :ssn]
      persist.to = "http://www.example.com/person"
    end
  end
end


class Laptop
  attr_accessor :assiged_to, :serial_number

  def save
    PostGateway.save do |persist|
      persist.subject = self
      persist.attributes = [:assigned_to, :serial_number]
      persist.to = "http://www.example.com/issued_laptops"
      persist.authenticate = true
    end
  end
end






