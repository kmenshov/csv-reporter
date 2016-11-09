module AccountsTransactionsMerchants

  def transactions(options = {})
    end_date   = options[:to]   || Time.now
    start_date = options[:from] || Time.at(0)

    Transaction.where(account: self.accounts, datetime: (start_date..end_date))
  end


  def report_by_merchants(options = {})

    transactions(from: options[:from], to: options[:to]).
                 select(:merchant_id,
                        'SUM("amount") as "amount"',
                        'SUM("tCommission") as "tCommission"').
                 group(:merchant_id)


    ### Is there a way to get rid of SQL completely and only use ActiveRecord calls? ###
    # amounts     = transactions.group(:merchant_id).sum(:amount)
    # commissions = transactions.group(:merchant_id).sum(:tCommission)
    # amounts.merge(commissions) { |key, amount, commission| [amount, commission] }
  end

end