class Client < ApplicationRecord

  # NOTE: You should move these associations to the User model and remove this file, because you don’t actually have clients in your database. All records are stored in the Users table.

  belongs_to :stylist, class_name: "User"
  has_many :recommendations
end
