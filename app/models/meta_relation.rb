# == Schema Information
#
# Table name: meta_relations
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  meta_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MetaRelation < ActiveRecord::Base
  validates_uniqueness_of :movie_id, :scope => :meta_id
  belongs_to :meta
  belongs_to :movie
end
