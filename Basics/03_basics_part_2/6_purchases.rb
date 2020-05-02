purchases = {}

loop do
  print 'Enter product label: '
  label = gets.chomp.to_sym

  break if label == :стоп

  print 'Enter unit price: '
  unit_price = gets.chomp.to_f

  print 'Enter product quantity: '
  quantity = gets.chomp.to_f

  if purchases[label].nil?
    purchases[label] = { unit_price: unit_price, quantity: quantity }
  else
    purchases[label][:quantity] += quantity
  end
end

purchases_money = purchases.transform_values do |purchase|
  (purchase[:unit_price] * purchase[:quantity]).round(2)
end

money_spent = purchases_money.sum { |label, money| money } # or .sum(&:last)

puts 'All purchases:', purchases
puts 'Money spent on each purchase', purchases_money
puts 'Total money spent:', money_spent
