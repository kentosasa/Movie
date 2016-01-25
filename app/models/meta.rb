# == Schema Information
#
# Table name: meta
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  category    :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Meta < ActiveRecord::Base
  validates_uniqueness_of :name, :scope => :category
  has_many :casts
end
