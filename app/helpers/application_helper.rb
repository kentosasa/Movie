module ApplicationHelper
  def default_meta_tags
    title = 'Dekopon 映画の予告映像とあらすじ'
    {
      site: "#{title}",
      reverse: true,
      description: '映画作品最新映画情報、ランキング、映画レビュー、あらすじ、感想、予告映像などみんなが知りたい情報がたくさん！',
      keywords: "映画, PV, 予告, 予告映像, 劇場, 映画館, あらすじ, 感想, レビュー",
      canonical: request.original_url,
      og: {
        title: "#{title}",
        type: "article",
        url: request.original_url,
        image: "http://userdisk.webry.biglobe.ne.jp/002/884/95/N000/000/001/122769971396716214170.PNG",
        site_name: :site,
        description: :description,
        locale: 'ja_JP'
      },
      twitter: {
        card: "summary",
        title: "#{title}",
        description: :description,
        image: "http://userdisk.webry.biglobe.ne.jp/002/884/95/N000/000/001/122769971396716214170.PNG"
        }
      }
  end
end
