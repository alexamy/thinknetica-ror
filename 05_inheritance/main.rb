require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'carriage'
require_relative 'seed'
require_relative 'ui'
require_relative 'railway_trains'
require_relative 'railway_stations'
require_relative 'railway_routes'
require_relative 'railway_validator'
require_relative 'railway'
require_relative 'interactive_shell'

title = 'Railway Manager'
stop_word = 'Exit'
menu = [
  'Exit',
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

railway = Railway.new
shell = InteractiveShell.new(railway, title, menu, stop_word)
shell.run
