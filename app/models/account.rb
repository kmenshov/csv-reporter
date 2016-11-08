class Account < ActiveRecord::Base
  belongs_to :family
  has_many :transactions
end
