cart = {}

puts "Select action."

loop do
  puts "Add to cart => add | Show => show | Exit => exit"
  user_choice = gets.strip.downcase
  
  break if user_choice == "exit"

  if user_choice == "add"
    print "Input product name: "
    product_name = gets.strip.to_sym

    print "Price per one: "
    product_price = gets.strip.to_f

    print "Input quantity: "
    product_count = gets.strip.to_f

    sum = product_price * product_count

    if (sum > 0)
      cart[product_name] = Hash.new(0) if !cart[product_name]
      cart[product_name][:product_price] = product_price 
      cart[product_name][:product_count] += product_count 
      cart[product_name][:sum] = product_price * cart[product_name][:product_count] 
    else
      puts "Quantity and price should be positive! Can't add product to the cart."
    end
  
  elsif user_choice == "show"
    total_sum = 0
    cart.each do |name, item| 
      puts "#{name}: #{item[:sum].round(2)} $. (#{item[:product_count]} x #{item[:product_price]} $.)"
      total_sum += item[:sum]
    end
    puts "Total: #{total_sum.round(2)} $."
  
  else 
    puts "Wrong input."
  
  end

end

