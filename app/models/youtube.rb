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
  validates :youtube_id, presence: true
  def thumbnail
    return "http://img.youtube.com/vi/#{self.youtube_id}/maxresdefault.jpg"
  end
end
