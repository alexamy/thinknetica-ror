require_relative 'kernel.rb'
require_all '.'

title = 'Railway Manager'
stop_word = 'Exit'
menu = [
  'Exit',
  'Add train',
  'Add station',
  'Add route',
  'Add station to route',
  'Remove station from route',
  'Add carriage to train',
  'Remove carriage from train',
  'Use space in carriage',
  'Place train on route',
  'Move train to next station',
  'Move train to previous station',
  'Show trains',
  'Show routes',
  'Show stations'
]

puts 'Print test data:'
puts
Seed.new.iterate_all
puts

railway = Railway.new
shell = InteractiveShell.new(railway, title, menu, stop_word)
shell.run
