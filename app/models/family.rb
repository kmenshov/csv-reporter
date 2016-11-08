class Family < ActiveRecord::Base
  belongs_to :school
  has_many :accounts
end
