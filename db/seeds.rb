# db/seeds.rb

puts "Seeding BookStore Database..."

puts "Creating users..."

admin = User.find_or_create_by!(email: "admin@bookstore.com") do |user|
  user.name = "Admin"
  user.password = "password123"
  user.role = :admin
  user.active = true
end

customers = []

5.times do |i|
  customer = User.find_or_create_by!(email: "customer#{i + 1}@bookstore.com") do |user|
    user.name = "Customer #{i + 1}"
    user.password = "password123"
    user.role = :customer
    user.active = true
  end

  customers << customer
end

puts "Creating categories..."

programming = Category.find_or_create_by!(name: "Programming")
science     = Category.find_or_create_by!(name: "Science")
business    = Category.find_or_create_by!(name: "Business")
history     = Category.find_or_create_by!(name: "History")
fiction     = Category.find_or_create_by!(name: "Fiction")

puts "Creating books..."
Book.find_or_create_by!(isbn: "9780132350884") do |book|
  book.title = "Clean Code"
  book.author = "Robert C. Martin"
  book.price = 45.99
  book.description = "A handbook of Agile software craftsmanship."
  book.stock = 25
  book.cover_url = "https://example.com/clean_code.jpg"
  book.published = true
  book.category = programming
end

Book.find_or_create_by!(isbn: "9780201616224") do |book|
  book.title = "The Pragmatic Programmer"
  book.author = "Andrew Hunt"
  book.price = 49.99
  book.description = "Journey to mastery."
  book.stock = 20
  book.cover_url = "https://example.com/pragmatic_programmer.jpg"
  book.published = true
  book.category = programming
end

Book.find_or_create_by!(isbn: "9780321584106") do |book|
  book.title = "Eloquent Ruby"
  book.author = "Russ Olsen"
  book.price = 39.99
  book.description = "Write idiomatic Ruby."
  book.stock = 18
  book.cover_url = "https://example.com/eloquent_ruby.jpg"
  book.published = true
  book.category = programming
end

Book.find_or_create_by!(isbn: "9780138050061") do |book|
  book.title = "Ruby on Rails Tutorial"
  book.author = "Michael Hartl"
  book.price = 54.99
  book.description = "Learn Rails by building applications."
  book.stock = 15
  book.cover_url = "https://example.com/rails_tutorial.jpg"
  book.published = true
  book.category = programming
end

Book.find_or_create_by!(isbn: "9780553380163") do |book|
  book.title = "A Brief History of Time"
  book.author = "Stephen Hawking"
  book.price = 19.99
  book.description = "Cosmology explained simply."
  book.stock = 30
  book.cover_url = "https://example.com/history_of_time.jpg"
  book.published = true
  book.category = science
end

Book.find_or_create_by!(isbn: "9780345539434") do |book|
  book.title = "Cosmos"
  book.author = "Carl Sagan"
  book.price = 24.99
  book.description = "Journey through the universe."
  book.stock = 22
  book.cover_url = "https://example.com/cosmos.jpg"
  book.published = true
  book.category = science
end

Book.find_or_create_by!(isbn: "9780199291151") do |book|
  book.title = "The Selfish Gene"
  book.author = "Richard Dawkins"
  book.price = 21.99
  book.description = "Evolution and genetics."
  book.stock = 12
  book.cover_url = "https://example.com/selfish_gene.jpg"
  book.published = true
  book.category = science
end

Book.find_or_create_by!(isbn: "9780393609394") do |book|
  book.title = "Astrophysics for People in a Hurry"
  book.author = "Neil deGrasse Tyson"
  book.price = 17.99
  book.description = "Astrophysics made easy."
  book.stock = 16
  book.cover_url = "https://example.com/astrophysics.jpg"
  book.published = true
  book.category = science
end

Book.find_or_create_by!(isbn: "9780735211292") do |book|
  book.title = "Atomic Habits"
  book.author = "James Clear"
  book.price = 23.99
  book.description = "Build better habits."
  book.stock = 40
  book.cover_url = "https://example.com/atomic_habits.jpg"
  book.published = true
  book.category = business
end

Book.find_or_create_by!(isbn: "9780307887894") do |book|
  book.title = "The Lean Startup"
  book.author = "Eric Ries"
  book.price = 29.99
  book.description = "Startup methodology."
  book.stock = 18
  book.cover_url = "https://example.com/lean_startup.jpg"
  book.published = true
  book.category = business
end

Book.find_or_create_by!(isbn: "9780804139298") do |book|
  book.title = "Zero to One"
  book.author = "Peter Thiel"
  book.price = 26.99
  book.description = "Notes on startups."
  book.stock = 14
  book.cover_url = "https://example.com/zero_to_one.jpg"
  book.published = true
  book.category = business
end

Book.find_or_create_by!(isbn: "9780857197689") do |book|
  book.title = "The Psychology of Money"
  book.author = "Morgan Housel"
  book.price = 22.99
  book.description = "Lessons on wealth."
  book.stock = 20
  book.cover_url = "https://example.com/psychology_money.jpg"
  book.published = true
  book.category = business
end

Book.find_or_create_by!(isbn: "9781451648539") do |book|
  book.title = "Steve Jobs"
  book.author = "Walter Isaacson"
  book.price = 29.99
  book.description = "The official biography of Steve Jobs based on more than forty interviews with Jobs and over one hundred interviews with family, friends, colleagues, and competitors."
  book.stock = 25
  book.cover_url = "https://example.com/steve_jobs.jpg"
  book.published = true
  book.category = business
end

Book.find_or_create_by!(isbn: "9780062316110") do |book|
  book.title = "Sapiens"
  book.author = "Yuval Noah Harari"
  book.price = 24.99
  book.description = "History of humankind."
  book.stock = 25
  book.cover_url = "https://example.com/sapiens.jpg"
  book.published = true
  book.category = history
end

Book.find_or_create_by!(isbn: "9780393354324") do |book|
  book.title = "Guns, Germs, and Steel"
  book.author = "Jared Diamond"
  book.price = 28.99
  book.description = "The fate of human societies."
  book.stock = 18
  book.cover_url = "https://example.com/guns_germs_steel.jpg"
  book.published = true
  book.category = history
end

Book.find_or_create_by!(isbn: "9781101912379") do |book|
  book.title = "The Silk Roads"
  book.author = "Peter Frankopan"
  book.price = 27.99
  book.description = "A new history of the world."
  book.stock = 12
  book.cover_url = "https://example.com/silk_roads.jpg"
  book.published = true
  book.category = history
end

Book.find_or_create_by!(isbn: "9780743226721") do |book|
  book.title = "1776"
  book.author = "David McCullough"
  book.price = 20.99
  book.description = "American Revolution history."
  book.stock = 10
  book.cover_url = "https://example.com/1776.jpg"
  book.published = true
  book.category = history
end
Book.find_or_create_by!(isbn: "9780590353427") do |book|
  book.title = "Harry Potter and the Sorcerer's Stone"
  book.author = "J.K. Rowling"
  book.price = 18.99
  book.description = "The first Harry Potter novel."
  book.stock = 50
  book.cover_url = "https://example.com/harry_potter1.jpg"
  book.published = true
  book.category = fiction
end

Book.find_or_create_by!(isbn: "9780547928227") do |book|
  book.title = "The Hobbit"
  book.author = "J.R.R. Tolkien"
  book.price = 16.99
  book.description = "Fantasy adventure."
  book.stock = 28
  book.cover_url = "https://example.com/hobbit.jpg"
  book.published = true
  book.category = fiction
end

Book.find_or_create_by!(isbn: "9780451524935") do |book|
  book.title = "1984"
  book.author = "George Orwell"
  book.price = 14.99
  book.description = "Dystopian fiction."
  book.stock = 35
  book.cover_url = "https://example.com/1984.jpg"
  book.published = true
  book.category = fiction
end

Book.find_or_create_by!(isbn: "9780061122415") do |book|
  book.title = "The Alchemist"
  book.author = "Paulo Coelho"
  book.price = 15.99
  book.description = "Inspirational novel."
  book.stock = 40
  book.cover_url = "https://example.com/alchemist.jpg"
  book.published = true
  book.category = fiction
end

puts "Creating carts..."

customers.each do |customer|
  Cart.find_or_create_by!(user: customer)
end

puts "Seed completed successfully!"
puts "Admin Login:"
puts "Email: admin@bookstore.com"
puts "Password: password123"