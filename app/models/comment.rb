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

class Comment < ActiveRecord::Base
  validates_uniqueness_of :text, :scope => :movie_id
  validates :user_name, :presence => true
  validates :text, :presence => true
  belongs_to :movie
  default_scope ->{ order("created_at desc") }
end
