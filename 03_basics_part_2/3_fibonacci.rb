numbers = [0, 1]
100.times { numbers << numbers.last(2).sum }

puts numbers
