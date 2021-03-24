class User < ApplicationRecord
  validates :post_code, length: {is: 5}, allow_nil: true
  validates :phone, length: {is: 11}, allow_nil: true
end
