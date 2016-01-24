# == Schema Information
#
# Table name: meta
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Meta < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :casts
end
