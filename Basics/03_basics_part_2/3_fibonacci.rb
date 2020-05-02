numbers = [0, 1]

loop do
  number_next = numbers.last(2).sum
  break if number_next >= 100
  numbers << number_next
end

puts numbers
