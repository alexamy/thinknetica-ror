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

is_leap = (year % 400 == 0) || !(year % 100 == 0) && (year % 4 == 0)
days_in_month[:february] = 29 if is_leap

day_number = day + days_in_month.take(month - 1).sum(&:last)

puts day_number
