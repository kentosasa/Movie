# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  user_name  :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
