system "bundle update"

class Operations

	def initialize
		@inventory = {}
		@prices = {}
		@sources = {}
		@sales = 0.00
	end

	attr_reader :inventory, :prices, :sources

	def register(fruit, price)
		fruit = fruit.to_s
		fruit.capitalize!
		price = price.to_f.round(2)
		@inventory[fruit] = 0
		@prices[fruit] = price
		@sources[fruit] = []

		done = false
		print "\nAdd a source (or q to stop): "
		while done != true
			input = gets.chomp
			if input == 'q'
				done = true
			else
				source = input.to_s
				@sources[fruit] << source
				print "\nAdd another source (or q to stop): "
			end
		end
	end
	
	def buy(fruit)
		if !(inventory.include? (fruit))
			puts "\nThat fruit has not been registered!".red
			puts "No fruit bought.\n".red
		elsif inventory[fruit] == 0
			puts "We have no #{fruit}s left unfortunately!\n".red
		else
			fruit = fruit.to_s
			inventory[fruit] -= 1
			fruit_price = prices[fruit].to_f
			@sales += fruit_price.round(2)
			puts "\nYou have just bought a/an #{fruit}!".green
			print "There are now "
			@inventory[fruit] > 10 ? (print "#{@inventory[fruit]}".green) : (print "#{@inventory[fruit]}".red)
			puts " #{fruit}(s) left.\n\n"
		end
	end
	
	def update(fruit, stock)
		if !(inventory.include? (fruit))
			puts "\nThat fruit has not been registered!".red
			puts "No stock updated.\n".red
		else
			fruit = fruit.to_s
			stock = stock.to_i
			inventory[fruit] += stock
			puts "#{stock} #{fruit}(s) added!\n".green
		end
	end
	
	def check(fruit)
		if !(inventory.include? (fruit))
			puts "\nThat fruit has not been registered!".red
			puts "No stock checked.\n".red
		else
			fruit = fruit.to_s
			puts
			print "There are "
			@inventory[fruit] > 10 ? (print "#{@inventory[fruit]}".green) : (print "#{@inventory[fruit]}".red)
			print " #{fruit}s in stock.\n\n"
		end
	end

	def check_all
		inventory.each do |key_i, value_i|
			sources.each do |key_s, value_s|
				if key_i == key_s
					print "#{key_i} - ".yellow
					value_i > 10 ? (print "#{value_i}".green) : (print "#{value_i}".red)
					puts " - #{value_s}".blue
				end
			end
		end
	end

end

#--------------------------#

class Interface < Operations

	def initialize
		super
	end

	def print_title
		system "clear"
		puts "Sharad's GROCERY STORE".yellow
		puts "---------------------"
	end

	def enter_continue
		print "Press "
		print "enter".green
		puts " to continue"
		gets
		start
	end

	def start
		system "clear"
		print_title
		puts "Choose an operation:\n\n"
		puts "a.) Register a fruit"
		puts "b.) Buy a fruit"
		puts "c.) Update a fruit stock"
		puts "d.) Check a fruit's stock"
		puts "e.) Check all fruit stocks"
		puts "f.) Check sales"
		puts "g.) Exit".red
		print "\nSelect an option (a, b, c, d, e, f or g): "
		option = gets.chomp

		case option
		when 'a'
			print_title
			puts "--- Register a fruit ---\n\n"
			print "Enter the fruit's name: "
			fruit_name = gets.chomp
			fruit_name.capitalize!
			print "\nEnter the fruit's price: "
			fruit_price = gets.chomp
			fruit_price = fruit_price.to_f.round(2)
			register(fruit_name, fruit_price)
			start
		when 'b'
			print_title
			puts "--- Buy a fruit ---\n\n"
			print "Enter the fruit's name: "
			fruit_name = gets.chomp
			fruit_name.capitalize!
			buy(fruit_name)
			enter_continue
		when 'c'
			print_title
			puts "--- Update a fruit's stock ---\n\n"
			print "Enter the fruit's name: "
			fruit_name = gets.chomp
			fruit_name.capitalize!
			print "\nEnter the stock added: "
			stock = gets.chomp.to_i
			update(fruit_name, stock)
			enter_continue
		when 'd'
			print_title
			puts "--- Check a fruit's stock ---\n\n"
			print "Enter the fruit's name: "
			fruit_name = gets.chomp
			fruit_name.capitalize!
			check(fruit_name)
			enter_continue
		when 'e'
			print_title
			puts "--- Check all fruit stock ---\n\n"
			check_all
			puts
			enter_continue
		when 'f'
			print_title
			puts "--- Check sales ---\n\n"
			print "The total sales comes to: £#{@sales.round(2)}\n\n".blue
			enter_continue
		when 'g'
			system "clear"
		else
			puts "\nInvalid option! (press enter to continue)".red
			gets
			system "clear"
			start
		end
	end

end

new_interface = Interface.new
new_interface.start