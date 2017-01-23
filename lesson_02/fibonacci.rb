fibonacci_array = [0]

number = 1

until number > 100 do

  fibonacci_array << number
  number = fibonacci_array.last(2).reduce(:+)
  
end

puts fibonacci_array