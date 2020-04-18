# Год високосный, если он делится на четыре без остатка,
# но если он делится на 100 без остатка, это не високосный год.
# Однако, если он делится без остатка на 400, это високосный год.

days_in_month = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}

print 'Enter day of month: '
day = gets.chomp.to_i

print 'Enter month (as number): '
month = gets.chomp.to_i

print 'Enter year: '
year = gets.chomp.to_i

if year % 400 == 0
  is_leap = true
elsif year % 100 == 0
  is_leap = false
elsif year % 4 == 0
  is_leap = true
else
  is_leap = false
end

days_in_month[:february] = 29 if is_leap

day_number = day
days_in_month.values.each.with_index(1) do |days, index|
  break if index == month
  day_number += days
end
