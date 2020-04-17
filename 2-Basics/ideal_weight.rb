print 'What is your name? '
name = gets.chomp.capitalize

print 'What is your height? '
height = gets.chomp.to_i

weight_ideal = (height - 110) * 1.15

print "#{name}, your weight is "
puts weight_ideal > 0 ? weight_ideal.to_s : 'already optimal'
