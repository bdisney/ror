def get_input(param)
  value = 0

  until value > 0
    puts "#{param}:"
    value = gets.strip.to_f

    puts "Parameter #{param} should be positive number!" if value <= 0
  end
  value
end

def triangle_area(base, height)
  0.5 * base * height
end

puts 'Please input triangle base and triangle heigh for calculating.' 

base = get_input('Triangle base')
height = get_input('Triangle height')

area = triangle_area(base, height)

puts "Triangle area — #{area}"