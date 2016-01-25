# == Schema Information
#
# Table name: youtubes
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  youtube_id :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Youtube < ActiveRecord::Base
  validates :movie_id, uniqueness: true
  def thumbnail
    return "http://i.ytimg.com/vi/#{self.youtube_id}/mqdefault.jpg"
  end
end
