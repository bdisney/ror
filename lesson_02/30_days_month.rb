months = {
  January:   { duration: 31, name: "January" },
  February:  { duration: 28, name: "February" },
  March:     { duration: 31, name: "March" },
  April:     { duration: 30, name: "April" },
  May:       { duration: 31, name: "May" },
  June:      { duration: 30, name: "Jun" },
  July:      { duration: 31, name: "July" },
  August:    { duration: 31, name: "August" },
  September: { duration: 30, name: "September" },
  October:   { duration: 31, name: "October" },
  November:  { duration: 30, name: "November" },
  December:  { duration: 31, name: "December" }
}

puts '30 days months:'

x = 0

months.each_value { |month| puts (x += 1).to_s + '. ' + month[:name] if month[:duration] == 30 }