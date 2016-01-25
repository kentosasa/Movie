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
  has_many :meta_relations
  has_many :metas, through: :meta_relations
  has_many :comments
  has_one :youtube
  before_save :prepare_save
  default_scope ->{ where(status: 1) }

  def self.feed
    Movie.where(status: 1)
  end

  def director
    self.metas.where(category: 0).first
  end

  def prepare_save
    self.title = self.title.strip
  end
end
