class Client < ApplicationRecord
  belongs_to :stylist, class_name: "User"
  has_many :recommendations
end
