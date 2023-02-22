# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Administrator.create(email: "admin@email.com", password: "secret")

User.create(name: "helmi", email: "helmi@gmail.com", password: "secret")
User.create(name: "adnreas", email: "andreas@gmail.com", password: "secret")

#Deposit
10.times do
    TransferService.execute(to_id: User.first.id, transfer_amount: rand(10) * 1000, transfer_code: "deposit")
    TransferService.execute(to_id: User.second.id, transfer_amount: rand(10) * 1000, transfer_code: "deposit")
end

#withdraw
5.times do
    TransferService.execute(from_id: User.first.id, transfer_amount: rand(10) * 100, transfer_code: "withdraw")
    TransferService.execute(from_id: User.second.id, transfer_amount: rand(10) * 100, transfer_code: "withdraw")
end

#transfer
5.times do
    TransferService.execute(from_id: User.second.id, to_id: User.first.id, transfer_amount: rand(10) * 100, transfer_code: "transfer")
    TransferService.execute(from_id: User.first.id, to_id: User.second.id, transfer_amount: rand(10) * 100, transfer_code: "transfer")
end