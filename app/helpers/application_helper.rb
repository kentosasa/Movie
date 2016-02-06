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
        title: 'Dekopon 映画の予告映像とあらすじ',
        type: "article",
        url: request.original_url,
        site_name: 'Dekopon 映画の予告映像とあらすじ',
        description: :description,
        locale: 'ja_JP'
      },
      twitter: {
        card: "summary",
        description: :title,
        }
      }
  end

  def set_title(par)
    set_meta_tags title: par, og: {title: par}, twitter: {description: "#{par} | Dekopon 映画の予告映像とあらすじ"}
  end
end
