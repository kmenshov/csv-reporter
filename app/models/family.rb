class Family < ActiveRecord::Base
  belongs_to :school
  has_many :accounts

  include AccountsTransactionsMerchants


# --------------------- SQL report by merchant ---------------------------------
#        (See the ActiveRecord version of the same report in
#         models/concerns/accounts_transactions_merchants.rb)

  def sql_report_by_merchants(options = {})
    end_date   = options[:to]   || Time.now
    start_date = options[:from] || Time.at(0)

    query  = "SELECT merchant_id, SUM(amount), SUM(\"tCommission\") FROM transactions "
    query +=    "INNER JOIN accounts ON transactions.account_id = accounts.id "
    query +=    "INNER JOIN families ON accounts.family_id = families.id "
    query += "WHERE datetime >= TIMESTAMP '#{start_date.to_s(:db)}' AND datetime <= TIMESTAMP '#{end_date.to_s(:db)}' "
    query +=    "AND families.id = #{self.id} "
    query += "GROUP BY merchant_id;"

    ActiveRecord::Base.connection.execute(query).values
  end

end