letters = ('a'..'z').to_a

vowels = %w[a e i o u y]

vowels_index = {}

i = 0

letters.each do |letter|
  i += 1

  if vowels.include?(letter)
    vowels_index[letter] = i
    puts i.to_s + '.' + letter
  end
end



