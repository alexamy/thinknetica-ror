print 'Enter first triangle side: '
side_a = gets.chomp.to_i

print 'Enter second triangle side: '
side_b = gets.chomp.to_i

print 'Enter third triangle side: '
side_c = gets.chomp.to_i

a, b, h = [side_a, side_b, side_c].sort

if h ** 2 == a ** 2 + b ** 2
  puts 'Triangle is right'
end

if a == b || b == h || a == h
  puts 'Triangle is isosceles'
end

if a == b && b == h
  puts 'Triangle is equilateral'
end
