class School < ActiveRecord::Base
  has_many :families
  has_many :accounts, through: :families

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
    query +=    "INNER JOIN schools ON families.school_id = schools.id "
    query += "WHERE datetime >= TIMESTAMP '#{start_date.to_s(:db)}' AND datetime <= TIMESTAMP '#{end_date.to_s(:db)}' "
    query +=    "AND schools.id = #{self.id} "
    query += "GROUP BY merchant_id;"

    ActiveRecord::Base.connection.execute(query).values
  end


# ----------------------- Reports by family ------------------------------------

  def report_by_families(options = {})

    transactions(from: options[:from], to: options[:to]).
                 joins(:account).
                 select(:family_id,
                        'SUM("amount") as "amount"',
                        'SUM("tCommission") as "tCommission"').
                 group(:family_id)

  end

  def sql_report_by_families(options = {})
    end_date   = options[:to]   || Time.now
    start_date = options[:from] || Time.at(0)

    query  = "SELECT family_id, SUM(amount), SUM(\"tCommission\") FROM transactions "
    query +=    "INNER JOIN accounts ON transactions.account_id = accounts.id "
    query +=    "INNER JOIN families ON accounts.family_id = families.id "
    query +=    "INNER JOIN schools ON families.school_id = schools.id "
    query += "WHERE datetime >= TIMESTAMP '#{start_date.to_s(:db)}' AND datetime <= TIMESTAMP '#{end_date.to_s(:db)}' "
    query +=    "AND schools.id = #{self.id} "
    query += "GROUP BY family_id;"

    ActiveRecord::Base.connection.execute(query).values
  end

end