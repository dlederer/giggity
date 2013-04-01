module GigsHelper
  def last_message gig
    return gig.messages.last ? gig.messages.last.content : ""
  end
end
