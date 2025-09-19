# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  brand       :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  has_many :recommendations, dependent: :destroy
end
