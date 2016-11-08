class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :merchant

  def self.import_row(row)
    # I know it's ugly, just didn't yet think about how to make it prettier.
    # Consider it's a mockup.
    # And anyways we need a BUNCH of validations here. But first things first. :)

    amount = BigDecimal(row['TranAmount'])
    tCommission = nil

    if merchant = Merchant.find_by_id(row['MerchantID'])
      tCommission = amount * merchant.commissionRate / 100 # both are BigDecimals by now
    end

    Transaction.create! datetime: DateTime.parse(row['TranDate']+row['TranTime']),
                        idTypeTransaction: row['TranCode'],
                        amount: amount,
                        account: Account.find_by_id(row[0]),
                        merchant: merchant,
                        tCommission: tCommission

  end
end
