fibonacci_numbers = []

steps = [0, 1]
100.times do
  fibonacci_numbers << steps.last
  steps = [steps.last, steps.first + steps.last]
end
