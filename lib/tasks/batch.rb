class Tasks::Batch
  def self.execute
    2326.upto(100000) do |i|
      movie = get_movie("http://movie.walkerplus.com/mv#{i}/")
      youtube(movie)
    end
  end

  #使ってない
  def self.get_list
    list = []
    1.upto(100) do |i|
      response = Faraday.get "http://movies.yahoo.co.jp/movie/?page=#{i}"
      doc = Nokogiri::HTML.parse(response.body)
      doc.css('.text-xsmall.text-overflow').each do |title|
        tmp = {}
        tmp[:title] = title["title"]
        tmp[:image] = title.css('.thumbnail__figure').map{ |n| n['style'][/url\((.+)\)/, 1] }
        list << tmp
      end
    end
  end

  def self.youtube(movie)
    q = movie.title
    movie_id = movie.id
    tmp = {}
    client = Google::APIClient.new(
      application_name: 'Example Ruby application',
      application_version: '1.0.0'
    )
    youtube = client.discovered_api('youtube', 'v3')

    client.key = "AIzaSyBtFzBLcBPM3TRia7AnXRpqX_SCY3y1-KM"
    client.authorization = nil
    result = client.execute(
      api_method: youtube.search.list,
      parameters: { :part => 'snippet',
        :q => q,
        :maxResults => 50 }
    )
    result.data.to_hash["items"].each do |item|
      if item["snippet"]["title"].include?("予告")
        tmp[:id] = item["id"]["videoId"]
        tmp[:title] = item["snippet"]["title"]
      end
    end
    unless tmp[:id].present?
      item = result.data.to_hash["items"]
      return unless item.present?
      tmp[:id] = item[0]["id"]["videoId"]
      tmp[:title] = item[0]["snippet"]["title"]
    end
    Youtube.create(movie_id: movie_id, youtube_id: tmp[:id], title: tmp[:title].strip)
  end

  # コメントの取得
  def self.youtube_comment
    id = "5icN4ISebN8"
    response = Faraday.get "https://www.googleapis.com/youtube/v3/commentThreads?key=AIzaSyBtFzBLcBPM3TRia7AnXRpqX_SCY3y1-KM&textFormat=plainText&part=snippet&videoId=#{id}&maxResults=50"

    JSON.parse(response.body)["items"].each do |item|
      comment = {}
      item = item["snippet"]["topLevelComment"]["snippet"]
      comment[:text] = item["textDisplay"]
      comment[:user_image] = item["authorProfileImageUrl"]
      comment[:user_name] = item["authorDisplayName"]
    end
  end

  def self.get_movie(url)
    response = Faraday.get url
    doc = Nokogiri::HTML.parse(response.body)

    movie = Movie.create(title: doc.css("#pageHeader .wrap h1").text)
    movie = Movie.find_by_title(doc.css("#pageHeader .wrap h1").text)

    description = doc.css("#mainInfo p").text
    description = doc.css("#mainInfoNoImage p").text unless description.present?
    movie.update(description: description.strip)

    movie.update(story: doc.css("#strotyText").text.strip)

    doc.css("#infoBox tr").each do |info|
      movie.update(year: info.css("td").text.strip) if "製作年" == info.css("th").text
    end

    doc.css("#staffArea tr").each do |staff|
      if "監督" == staff.css("th").text
        meta = Meta.create(name: staff.css("td a").text.strip, category: 0)
        meta = Meta.where(name: staff.css("td a").text.strip, category: 0).first
        MetaRelation.create(movie_id: movie.id, meta_id: meta.id)
      end

      if "脚本" == staff.css("th").text
        meta = Meta.create(name: staff.css("td a").text.strip, category: 1)
        meta = Meta.where(name: staff.css("td a").text.strip, category: 1).first
        MetaRelation.create(movie_id: movie.id, meta_id: meta.id)
      end

      if "原作" == staff.css("th").text
        meta = Meta.create(name: staff.css("td a").text.strip, category: 2)
        meta = Meta.where(name: staff.css("td a").text.strip, category: 2).first
        MetaRelation.create(movie_id: movie.id, meta_id: meta.id)
      end
    end

    doc.css("#castArea tr").each do |cast|
      meta = Meta.create(name: cast.css("td a").text.strip, category: 3)
      meta = Meta.where(name: cast.css("td a").text.strip, category: 3).first
      MetaRelation.create(movie_id: movie.id, meta_id: meta.id)
    end

    return movie
  end
end