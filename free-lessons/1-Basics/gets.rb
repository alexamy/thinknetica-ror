puts "What is your name?"
name = gets.chomp
puts "What is your birth year?"
year = gets.chomp.to_i

puts "Hello, #{name}, have a good day! You age is #{2020 - year}."
