class Fruit

	#Initializer

	def initialize(fruit_name, fruit_price, fruit_stock = 1)
		@fruit_name = fruit_name
		@fruit_name.to_s.capitalize!
		@fruit_price = fruit_price
		@fruit_price.to_f
		# @fruit_price.round(2)
		@fruit_stock = fruit_stock.to_i
		@fruit_source = []
	end

	attr_reader :fruit_name, :fruit_stock, :fruit_price

	def fruit_source
		@fruit_source
	end

	def add_fruit_source

		done = false
		
		while done != true do
			puts "What is the fruit's source (q to quit)?"
			input = gets.chomp.to_s
			if input == 'q'
				done = true
				system "clear"
			elsif input == ''
				puts "Enter something!"
				system "clear"
			else
				fruit_source = input
				@fruit_source << fruit_source.to_s
				system "clear"
				puts "Saved!"
			end
		end

	end

	def update_fruit_stock(fruit_stock)
		@fruit_stock = fruit_stock.to_i
	end

	def describe_fruit
		puts "There are #{fruit_stock} #{@fruit_name}(s) that cost £#{fruit_price} that are from:"
		puts @fruit_source
	end

end



class Grocery_Store < Fruit

	#Initializer

	def initialize
		@inventory = []
		@income = 0
	end

	def inventory
		puts @inventory
	end

	def add_fruit (fruit)
		@inventory << {fruit_name: fruit.fruit_name, fruit_price: fruit.fruit_price, fruit_stock: fruit.fruit_stock, fruit_source: fruit.fruit_source}
	end

	def fruit_stock(input)

		desired_fruit = input.fruit_name

		we_sell = false
		in_stock = false
		stock_no = 0

		@inventory.each do |item|

			found_fruit = false

			item.each do |key, value|

				if value.is_a? Integer
					if value.to_i > 0 && found_fruit == true
						in_stock = true
						stock_no = value
						found_fruit = false
					end
				end

				if value == desired_fruit
					we_sell = true
					found_fruit = true
				end

			end

		end

		if we_sell && in_stock
			puts "We have #{stock_no} #{desired_fruit}s in stock!"
		elsif we_sell && !in_stock
			puts "We have unfortunately run out of stock."
		else
			puts "We do not sell that fruit here, sorry."
		end

	end

end



def interface
	system "clear"
	romeo_grocery_store = Grocery_Store.new
	puts "Romeo's GROCERY STORE"
	puts "Choose an operation:"
	puts "a.) Register a fruit"
	puts "b.) Buy a fruit"
	puts "c.) Update a fruit stock"
	puts "d.) Check fruit stocks"
	puts "Select an option (a, b, c, or d)"
	option = gets.chomp
	case option
	when "a"
		system "clear"
  	print "Enter the fruit name: "
  	fr_name = gets.chomp
  	fr_name.to_s.capitalize!
  	system "clear"
  	print "Enter the fruit price: "
  	fr_price = gets.chomp
  	fr_price.to_f.round(2)
  	system "clear"
  	print "Enter the fruit stock: "
  	fr_stock = gets.chomp
  	fr_stock.to_i
  	system "clear"
  	fr_object = fr_name.downcase!
  	fr_object = Fruit.new(fr_name, fr_price, fr_stock)
  	fr_object.add_fruit_source
  	romeo_grocery_store.add_fruit(fr_object)
  	puts romeo_grocery_store.inventory
  	input = ""
  	while input != 'b' do
  		puts "Fruit registered! (press b to go back)"
  		input = gets.chomp
  		system "clear"
  	end
  	interface
	when "b"
		system "clear"
  	puts 'b'
	when "c"
		system "clear"
  	puts 'c'
	when "d"
		system "clear"
		print "What fruit do you want to check stock for? "
		fruit_input = gets.chomp.to_s
		# puts @inventory
		puts fruit_input
		puts romeo_grocery_store.inventory
  	puts romeo_grocery_store.fruit_stock(fruit_input)
  else
  	system "clear"
  	puts "Invalid option!"
	end 
end

interface
