def arr(min, max, delta)
  arr = []
  number = min

  until number > max do
    arr << number
    number += delta
  end

  arr

end

puts arr(10, 100, 5)