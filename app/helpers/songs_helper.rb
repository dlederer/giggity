module SongsHelper
  
  def embed_song song
    if song.embed_code
      return embed_soundcloud song.embed_code
    end
  end
  
  def embed_soundcloud song_url
    html = '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url='
    html += song_url
    html += '"></iframe>'
    return html.html_safe
  end
end
