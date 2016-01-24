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

require 'test_helper'

class YoutubeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
