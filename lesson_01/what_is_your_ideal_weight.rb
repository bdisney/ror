puts "What is your name?: "
name = gets.strip.downcase

puts "What's your height?: "
height = gets.strip.to_i

perfect_weight = height - 110

puts "#{name.capitalize}, your ideal weight is  #{perfect_weight} kg"
