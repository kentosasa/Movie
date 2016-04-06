# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://www.decopon.link' # ホスト名
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/' # 保存先（この場合 /public/sitemaps/以下になる）

SitemapGenerator::Sitemap.create do
  add root_path, :priority => 0.9, :changefreq => 'daily'
  Movie.where(status: 1).each do |movie|
    if movie.comments.present?
      add movie_path(movie), :lastmod => movie.comments.last.created_at
    else
      add movie_path(movie), :lastmod => movie.updated_at
    end
  end
  Meta.all.each do |meta|
    add meta_path(meta), :lastmod => meta.movies.last.created_at
  end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
