print "Enter first triangle side: "
a = gets.chomp.to_i

print "Enter second triangle side: "
b = gets.chomp.to_i

print "Enter third triangle side: "
c = gets.chomp.to_i

if a >= b && a >= c
  is_right = a ** 2 == b ** 2 + c ** 2
elsif b >= a && b >= c
  is_right = b ** 2 == a ** 2 + c ** 2
else
  is_right = c ** 2 == a ** 2 + b ** 2
end

if is_right
  puts "Triangle is right"
end

if a == b || b == c || a == c
  puts "Triangle is isosceles"
end

if a == b && b == c
  puts "Triangle is equilateral"
end
