module ApplicationHelper
  def default_meta_tags
    title = 'Dekopon'
    {
      site: "#{title}",
      reverse: true,
      description: '映画作品最新映画情報、ランキング、映画レビュー、あらすじ、感想、予告映像などみんなが知りたい情報がたくさん！',
      og: {
        title: "#{title}",
        # type: Settings.site[:meta][:og][:type],
        url: root_url,
        # image: image_url(Settings.site[:meta][:og][:image]),
        site_name: :site,
        description: :description,
        locale: 'ja_JP'
      },
      twitter: {
        # card: Settings.site[:meta][:twitter][:card],
        # site: Settings.site[:meta][:twitter][:site],
        # title: Settings.site[:name],
        # description: Settings.site[:page_description],
        # image: {_: image_url(Settings.site[:meta][:og][:image])}
        }
      }
  end
end
