# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  year        :integer
#  description :text
#  story       :text
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Movie < ActiveRecord::Base
  validates_uniqueness_of :title
  has_one :youtube
  before_save :prepare_save

  def casts
    Cast.where(self.id)
  end

  def prepare_save
    self.title = self.title.strip
  end
end
