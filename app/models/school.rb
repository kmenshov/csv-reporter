class School < ActiveRecord::Base
  has_many :families

  def accounts
    Account.where(family: self.families)
  end

  def report_by_merchants(options = {})
    end_date   = options[:to]   || Time.now
    start_date = options[:from] || Time.at(0)

    transactions = Transaction.where account: self.accounts,
                                     datetime: (start_date..end_date)

    # there SHOULD be a better way to do this!
    amounts     = transactions.group(:merchant_id).sum(:amount)
    commissions = transactions.group(:merchant_id).sum(:tCommission)
    amounts.merge(commissions) { |key, amount, commission| [amount, commission] }
  end


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

end
