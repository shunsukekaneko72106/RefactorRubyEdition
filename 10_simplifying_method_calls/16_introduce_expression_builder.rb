# 式ビルダーの導入
# 式ビルダーを導入し、アプリケーション固有のインターフェースを作る

##### 前回までのコード #####

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


class GatewayExpressionBuilder
  def initialize(subject)
    @subject = subject
  end

  def post(attributes)
    @attributes = attributes
  end

  def to(address)
    PostGateway.save do |persist|
      persist.subject = @subject
      persist.attributes = @attributes
      persist.authenticate = @authenticate
      persist.to = address
    end
  end

  def with_authentication
    @authenticate = true
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

class Company < DomainObject
  attr_accessor :name, :tax_id

  def save
    http.get(:name, :tax_id).to("http://www.example.com/companies")
  end

  private

  def http
    GatewayExpressionBuilder.new(self)
  end
end


class Preson
  attr_accessor :first_name, :last_name, :ssn

  def save
    http.post(:first_name, :last_name, :ssn).to("http://www.example.com/people")
  end

  private

  def http
    GatewayExpressionBuilder.new(self)
  end
end


class Laptop
  attr_accessor :assiged_to, :serial_number

  def save
    http.post(:assigned_to, :serial_number).to("http://www.example.com/issued_laptops").with_authentication
  end
end






