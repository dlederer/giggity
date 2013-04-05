class Search
  include ActiveModel::Validations

  attr_accessor :query, :price_min, :price_max , :category_id
end
