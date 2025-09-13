# == Schema Information
#
# Table name: recommendations
#
#  id         :bigint           not null, primary key
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :integer
#  product_id :bigint           not null
#  stylist_id :integer
#
# Indexes
#
#  index_recommendations_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Recommendation < ApplicationRecord
  belongs_to :product, optional: true

end
