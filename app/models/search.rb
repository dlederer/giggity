class Search
  include ActiveModel::Validations

  attr_accessible :query, :price_min, :price_max , :category_id
end
