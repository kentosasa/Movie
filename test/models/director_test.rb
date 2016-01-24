# == Schema Information
#
# Table name: directors
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  meta_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DirectorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
