class Tasks::Batch
  def self.test
    Movie.all.each do |movie|
      youtube_comment(movie)
    end
  end

  def self.old_movie
    1995.upto(2015) do |i|
      1.upto(12) do |m|
        puts "http://movie.walkerplus.com/list/#{i}/#{sprintf("%02d",m)}/"
        response = Faraday.get "http://movie.walkerplus.com/list/#{i}/#{sprintf("%02d",m)}/"
        doc = Nokogiri::HTML.parse(response.body)
        doc.css('#personMovieList .hiraganaGroup .movie h3 a').each do |link|
          begin
            url = "http://movie.walkerplus.com#{link[:href]}"
            movie = get_movie(url)
            get_youtube(movie)
            youtube_comment(movie)
            if movie.youtube.present?
              Movie.find(movie.id).update(status: 1)
            else
              Movie.find(movie.id).update(status: 0)
            end
          rescue
            puts "undefined method `youtube' for nil:NilClass (NoMethodError)"
          end
        end
      end
    end
  end

  def self.recent_movie
    1.upto(15) do |i|
      response = Faraday.get "http://movie.walkerplus.com/list/#{i}.html"
      doc = Nokogiri::HTML.parse(response.body)
      doc.css('#onScreenBoxContent .onScreenBoxContentMovie h3 a').each do |link|
        begin
          url = "http://movie.walkerplus.com#{link[:href]}"
          movie = get_movie(url)
          get_youtube(movie)
          youtube_comment(movie)
          if movie.youtube.present?
            Movie.find(movie.id).update(status: 1)
          else
            Movie.find(movie.id).update(status: 0)
          end
        rescue
          puts "undefined method `youtube' for nil:NilClass (NoMethodError)"
        end
      end
    end
  end

  def self.update_comment
    Movie.where(status: 1)last(500).each do |movie|
      youtube_comment(movie)
    end
  end

  def self.crowl
    response = Faraday.get "http://movie.walkerplus.com/list/n1m/"
    doc = Nokogiri::HTML.parse(response.body)
    doc.css('#comingMovieList .movie h3 a').each do |movie|
      url = "http://movie.walkerplus.com/#{movie[:href]}"
      movie = get_movie(url)
      get_youtube(movie)
      youtube_comment(movie)
      if movie.youtube.present?
        Movie.find(movie.id).update(status: 1)
      else
        Movie.find(movie.id).update(status: nil)
      end
    end
  end

  # def self.execute
  #   repeat_count = 0
  #   1.upto(100000) do |i|
  #     repeat_count += 1
  #     puts repeat_count
  #     movie = get_movie("http://movie.walkerplus.com/mv#{i}/")
  #     youtube(movie)
  #     youtube_comment(movie)
  #   end
  #   set_status
  # end

  def self.set_status
    Movie.all.each do |movie|
      if movie.youtube.present?
        Movie.find(movie.id).update(status: 1)
      else
        Movie.find(movie.id).update(status: 0)
      end
    end
  end

  def self.get_youtube(movie)
    begin
      response = Faraday.get "https://www.youtube.com/results?search_query=#{movie.title}+映画"
      doc = Nokogiri::HTML.parse(response.body)
      a = doc.css("ol.item-section li h3.yt-lockup-title a.yt-uix-tile-link").first
      id = a[:href].gsub("/watch?v=", "")
      Youtube.create(movie_id: movie.id, youtube_id: id, title: a.text.strip)
    rescue
      puts "get youtube error"
    end
  end

  # #使ってない
  # def self.get_list
  #   list = []
  #   1.upto(100) do |i|
  #     response = Faraday.get "http://movies.yahoo.co.jp/movie/?page=#{i}"
  #     doc = Nokogiri::HTML.parse(response.body)
  #     doc.css('.text-xsmall.text-overflow').each do |title|
  #       tmp = {}
  #       tmp[:title] = title["title"]
  #       tmp[:image] = title.css('.thumbnail__figure').map{ |n| n['style'][/url\((.+)\)/, 1] }
  #       list << tmp
  #     end
  #   end
  # end

  # def self.youtube(movie)
  #   begin
  #     q = movie.title
  #     movie_id = movie.id
  #     tmp = {}
  #     client = Google::APIClient.new(
  #       application_name: 'Example Ruby application',
  #       application_version: '1.0.0'
  #     )
  #     youtube = client.discovered_api('youtube', 'v3')

  #     client.key = "AIzaSyBtFzBLcBPM3TRia7AnXRpqX_SCY3y1-KM"
  #     client.authorization = nil
  #     result = client.execute(
  #       api_method: youtube.search.list,
  #       parameters: { :part => 'snippet',
  #         :q => "#{q} 予告",
  #         :order => "viewCount",
  #         :maxResults => 50 }
  #     )
  #     result.data.to_hash["items"].each do |item|
  #       if item["snippet"]["title"].include?(q)
  #         tmp[:id] = item["id"]["videoId"]
  #         tmp[:title] = item["snippet"]["title"]
  #       end
  #     end
  #     unless tmp[:id].present?
  #       return
  #       # item = result.data.to_hash["items"]
  #       # return unless item.present?
  #       # tmp[:id] = item[0]["id"]["videoId"]
  #       # tmp[:title] = item[0]["snippet"]["title"]
  #     end
  #     # youtubeIDが存在しない場合があるからvalidationの制約をつけた
  #     Youtube.create(movie_id: movie_id, youtube_id: tmp[:id], title: tmp[:title].strip) if tmp[:id].present?
  #     if movie.youtube.present?
  #       movie.update(status: 1)
  #     else
  #       movie.update(status: nil)
  #     end
  #   rescue
  #     puts "youtube error"
  #   end
  # end

  # コメントの取得
  def self.youtube_comment(movie)
    begin
      return false unless movie.youtube.present?
      id = movie.youtube.youtube_id
      response = Faraday.get "https://www.googleapis.com/youtube/v3/commentThreads?key=AIzaSyBtFzBLcBPM3TRia7AnXRpqX_SCY3y1-KM&textFormat=plainText&part=snippet&videoId=#{id}&maxResults=50"
      result = []
      items = JSON.parse(response.body)["items"]
      return false unless items.present?
      items.each do |item|
        comment = {}
        item = item["snippet"]["topLevelComment"]["snippet"]
        comment[:text] = item["textDisplay"]
        comment[:user_image] = item["authorProfileImageUrl"]
        comment[:user_name] = item["authorDisplayName"]
        comment[:created_at] = DateTime.parse(item["updatedAt"])
        result << comment
      end
      result.each do |comment|
        Comment.create(movie_id: movie.id, user_name: comment[:user_name], text: comment[:text], created_at: comment[:created_at])
      end
    rescue
      puts "get comment error"
    end
  end

  def self.get_movie(url)
    begin
      response = Faraday.get url
      doc = Nokogiri::HTML.parse(response.body)
      title = doc.css("#pageHeader .wrap h1").text
      return unless title.present?
      movie = Movie.create(title: title)
      movie = Movie.find_by_title(title)

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
  rescue
    puts "get movie error"
  end
end
