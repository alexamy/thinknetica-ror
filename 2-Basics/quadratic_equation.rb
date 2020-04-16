print "Enter a of equation: "
a = gets.chomp.to_i

print "Enter b of equation: "
b = gets.chomp.to_i

print "Enter c of equation: "
c = gets.chomp.to_i

d = b ** 2 - 4 * a * c
unless d < 0
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
end

puts "Discriminant: #{d}"
if d > 0
  puts "Roots: #{x1}, #{x2}"
elsif d == 0
  puts "Root: #{x1}"
else
  puts "No roots exist"
end
