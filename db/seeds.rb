# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(name: 'Midye', role: 'admin', email: 'a@admin.com', password: '000000')
User.create(name: 'Happy Feet', role: 'user', email: 'hf@example.com', password: '000000')
User.create(name: 'Mickey Mouse', role: 'user', email: 'mm@example.com', password: '000000')
User.create(name: 'Donald Duck', role: 'user', email: 'dd@example.com', password: '000000')
User.create(name: 'Goofy', role: 'user', email: 'g@example.com', password: '000000')
User.create(name: 'Brown Bear', role: 'user', email: 'bb@example.com', password: '000000')
User.create(name: 'Panda', role: 'user', email: 'p@example.com', password: '000000')