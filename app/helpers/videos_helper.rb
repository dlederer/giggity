module VideosHelper
  def youtube_embed(youtube_url, width, height)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    html = '<iframe title="YouTube video player" width="'
    html += width.to_s
    html += '" height="'
    html += height.to_s
    html += '" src="http://www.youtube.com/embed/'
    html += youtube_id
    html += '" frameborder="0" allowfullscreen></iframe>'
    return html.html_safe
  end
end
