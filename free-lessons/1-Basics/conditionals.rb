alex_height   = 180
robert_height = 170
peter_height  = 160

if alex_height > robert_height
  puts "alex is taller than robert"
end

if alex_height < robert_height
  puts "alex is shorter than robert"
end

puts "alex is taller than robert" if alex_height > robert_height
puts "alex is shorter than robert" unless alex_height > robert_height

if alex_height > peter_height
  puts "alex is taller than peter"
else
  puts "alex is shorter than peter"
end

if peter_height > alex_height
  puts "peter is taller than alex"
elsif peter_height > robert_height
  puts "peter is taller than robert"
else
  puts "peter is the shortest"
end

if peter_height < alex_height && peter_height < robert_height
  puts "peter is the shortest"
end

a = 2
if a
  puts "a is not nil"
else
  puts "a is nil"
end
