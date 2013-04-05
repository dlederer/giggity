class Legacy::Importer
  def self.run
    Legacy::User.import_all
    Legacy::Conversation.import_all
    Legacy::Song.import_all
    Legacy::Video.import_all
    Legacy::Review.import_all
    Legacy::Post.import_all
    Legacy::Message.import_all
    
    Legacy::Message.flush_lookups!
    Legacy::Post.flush_lookups!
    Legacy::Review.flush_lookups!
    Legacy::Video.flush_lookups!
    Legacy::Song.flush_lookups!
    Legacy::Conversation.flush_lookups!
    Legacy::User.flush_lookups!
  end
end