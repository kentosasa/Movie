# == Schema Information
#
# Table name: originals
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  meta_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Original < ActiveRecord::Base
  validates :movie_id, uniqueness: { scope: [:meta_id] }
end
