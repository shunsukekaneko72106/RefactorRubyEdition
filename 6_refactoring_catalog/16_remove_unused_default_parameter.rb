# 使われていないデフォルト引数の除去（Remove Unused Default Parameter）
# デフォルト引数が使われていない場合は、デフォルト引数を削除する

##### Before #####

def product_count_items(search_criteria=nil)
  criteria = search_criteria || @search_criteria
  ProductCountItem.find_all_by_criteria(criteria)
end

##### After #####

def product_count_items(search_criteria)
  ProductCountItem.find_all_by_criteria(search_criteria)
end

