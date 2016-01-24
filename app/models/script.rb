# == Schema Information
#
# Table name: scripts
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  meta_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Script < ActiveRecord::Base
  validates :movie_id, uniqueness: { scope: [:meta_id] }
end
