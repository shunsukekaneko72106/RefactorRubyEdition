# コンストラクタからファクトリメソッドへ
# コンストラクタを取り除いて、代わりにファクトリメソッドを作る


##### Before #####
class ProductController
  def create
    //....

    @product = if imported
      ImportedProduct.new(base_price)
    else
      if base_price > 1000
        LuxuryProduct.new(base_price)
      else
        Product.new(base_price)
      end
    end
    //....
  end
end


##### After #####
class ProductController

  def create
    //....
    @product = Product.create(base_price, imported)
    //....
  end
end

class Product

  def self.create(base_price, imported)
    if imported
      ImportedProduct.new(base_price)
    else
      if base_price > 1000
        LuxuryProduct.new(base_price)
      else
        Product.new(base_price)
      end
    end
  end
end