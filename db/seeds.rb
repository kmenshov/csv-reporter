# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

schools_list = [
  %w(School1 school1@example.com),
  %w(School2 school2@example.com),
  %w(School3 school3@example.com)
]

families_list = [
  %w(Family1 family1@example.com School1),
  %w(Family2 family2@example.com School1),
  %w(Family3 family3@example.com School2),
]

accounts_list = [
  %w(2000000029002906 John      Doe      Family1),
  %w(2000000029001772 Jerry     Mouse    Family1),
  %w(2000000029000758 Donald    Duck     Family1),
  %w(2000000029000543 Micky     Mouse    Family2),
  %w(2000000029002887 Tom       Cat      Family3)
#  %w(2000000029000758 Preferred Customer Family3) - duplicate primary key (Account Number)
]

merchants_list =[
  %w(18617459 merchant1@example.com Merchant1 1.00),
  %w(215029   merchant2@example.com Merchant2 8.20),
  %w(34008628 merchant3@example.com Merchant3 7.01),
]

schools_list.each do |school|
  School.create!(sName: school[0], sEmail: school[1])
end

families_list.each do |family|
  Family.create!(familyName: family[0], fEmail: family[1],
                 school: School.find_by_sName!(family[2]))
end

accounts_list.each do |account|
  Account.create!(id: account[0].to_i, fName: account[1], lName: account[2],
                  family: Family.find_by_familyName!(account[3]))
end

merchants_list.each do |merchant|
  Merchant.create!(id: merchant[0].to_i, mEmail: merchant[1], mName: merchant[2],
                   commissionRate: merchant[3])
end