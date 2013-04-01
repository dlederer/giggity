class SearchesController < ApplicationController

  def create

    @new_search = Search.new

    if params[:search][:query] && params[:search][:query] != ""
      @query = params[:search][:query].downcase
    end

    if params[:search][:category] && params[:search][:category] != ""
      @category = params[:search][:category].downcase
    end

    if params[:search][:price_level] && params[:search][:price_level] != ""
      @price_level = params[:search][:price_level].downcase
    end

    if @query
      @users = User.where("LOWER(name) LIKE ? OR LOWER(email) LIKE ? OR LOWER(blurb) LIKE ? OR LOWER(category) LIKE ? OR LOWER(subcategory) LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%")
      if @category
        @featured = @performers.select { |performer|
          performer.featured?
        }
        @users = @users.select{ |user|
          user.category_id == category_id
        } 
        if @price_level
          @users = User.where("LOWER(name) LIKE ? OR LOWER(email) LIKE ? OR LOWER(blurb) LIKE ? OR LOWER(category) LIKE ? OR LOWER(subcategory) LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%").where("LOWER(category) = ?", @category).where("LOWER(price_level) = ?", @price_level).to_a
        end
      if @price_level
         @users = User.where("LOWER(name) LIKE ? OR LOWER(email) LIKE ? OR LOWER(blurb) LIKE ? OR LOWER(category) LIKE ? OR LOWER(subcategory) LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%").where("LOWER(category) = ?", @category).where("LOWER(price_level) = ?", @price_level).to_a
       end
      end
    elsif @category
      @users = User.where("LOWER(name) LIKE ? OR LOWER(email) LIKE ? OR LOWER(blurb) LIKE ? OR LOWER(category) LIKE ? OR LOWER(subcategory) LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%").where("LOWER(category) = ?", @category).to_a
      if @price_level
        @users = User.where("LOWER(name) LIKE ? OR LOWER(email) LIKE ? OR LOWER(blurb) LIKE ? OR LOWER(category) LIKE ? OR LOWER(subcategory) LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%").where("LOWER(category) = ?", @category).where("LOWER(price_level) = ?", @price_level).to_a
      end
    elsif @price_level
      @users = User.where("LOWER(price_level) = ?", @price_level).to_a
    else
      @users = User.all
    end

  end

end
