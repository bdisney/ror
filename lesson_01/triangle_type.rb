puts 'Please input triangle sides length.'
puts 'Enter the values separated by commas (for exmple: 1, 2, 4): '

sides = gets.strip.split(",").map! { |side| side.to_f}
sides.keep_if { |side| side > 0}
sides_count = sides.length

if sides_count < 3
  abort 'Invalid parameters. Be sure what all numbers are positive.'
end

if sides_count > 3
  sides = sides.take(3)
  puts 'You have entered the extra value, I use the first three: #{sides.join(', ')}.'
end

sides.sort!
longest_side = sides[2]

perimeter = sides.reduce(:+)
if perimeter - longest_side <= longest_side 
  abort "Wrong parameters! Triangle with entered length of sides doesn't exist!"
end
 
triangle_properties = []
if sides.uniq.length == 1
  triangle_properties.push("equilateral")
else
  triangle_properties.push("рisosceles") if sides.uniq.length == 2
  triangle_properties.push("rectangular") if longest_side**2 == (sides[0]**2 + sides[1]**2) 
end

puts triangle_properties.empty? ? 'Nothing interesting' : "Triangle is #{triangle_properties.join(", ")}."