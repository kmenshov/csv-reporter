class Merchant < ActiveRecord::Base
  has_many :transactions

# Did not implement the report for every single transaction of a specific merchant
# due to its triviality: self.transactions

end
