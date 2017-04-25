# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

penn = Institution.create({name: 'UPenn', password_hash: 'test', secret: 'test', email_regex: 'upenn.edu'})
test = Institution.create({name: 'Test', password_hash: 'test', secret: 'test', email_regex: 'test.com'})
other = Institution.create({name: 'Other', password_hash: 'test', secret: 'test', email_regex: 'gmail.com'})

a1 = Account.create({name: 'A1', email: 'test@test.com', password_hash: 'test', professor: false, institution: test})
a2 = Account.create({name: 'A2', email: 'test2@test.com', password_hash: 'test', professor: false, institution: test})
a3 = Account.create({name: 'A3', email: 'test3@test.com', password_hash: 'test', professor: false, institution: test})
a4 = Account.create({name: 'A4', email: 'test@seas.upenn.edu', password_hash: 'test', professor: false, institution: penn})
a5 = Account.create({name: 'A5', email: 'test@gmail.com', password_hash: 'test', professor: false, institution: other})
