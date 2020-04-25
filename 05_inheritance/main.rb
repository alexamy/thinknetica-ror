require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'carriage'
require_relative 'seed'
require_relative 'railway'
require_relative 'ui'

railway = Railway.new
menu = [
  'Stop',
  'Add train',
  'Add station',
  'Add route',
  'Add carriage',
  'Remove carriage',
  'Place train on route',
  'Move train to next station',
  'Move train to previous station',
  'Show stations',
  'Show trains on station',
  'Add station to route',
  'Remove station from route'
]

loop do
  puts 'Railway Manager'
  selected = Ui.choose_from(menu)
  return if selected == 'Stop'

  method = selected.downcase.gsub(' ', '_')
  result = railway.public_send(method)
  puts result

  print 'Press any key'
  STDIN.getc
end
