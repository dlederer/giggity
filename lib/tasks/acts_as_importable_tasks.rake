namespace :acts_as_importable do
  desc "Import the legacy data."
  task :import => :environment do
    Legacy::Importer.run
  end
end