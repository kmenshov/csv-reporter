class Merchant < ActiveRecord::Base
  has_many :transactions
end
