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
  belongs_to :movie
end
