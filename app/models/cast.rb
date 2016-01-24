# == Schema Information
#
# Table name: casts
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  meta_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cast < ActiveRecord::Base
  validates :movie_id, uniqueness: { scope: [:meta_id] }
  belongs_to :movie
  belongs_to :meta
end
