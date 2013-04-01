# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html

["Music", "Comedy", "Magic", "Visual Art", "Dance", "Multiple", "Other"].each do |cat|
  Category.find_or_create_by_name(cat)
end

["Colgate University", "Bowdoin College"].each do |col|
    College.find_or_create_by_name(col)
end