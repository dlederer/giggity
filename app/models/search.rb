class Search
  include ActiveModel::Model

  attr_accessible :query, :price_min, :price_max , :category_id
end
