require_relative 'ui/ui'
require_relative 'ui/interactive_shell'
require_relative 'modules/instance_counter'
require_relative 'modules/manufacturer'
require_relative 'modules/init_validator'
require_relative 'modules/seed_stations_iterator'
require_relative 'entity/train_route'
require_relative 'entity/train'
require_relative 'entity/station'
require_relative 'entity/route'
require_relative 'entity/carriage_space'
require_relative 'entity/carriage'
require_relative 'railway/railway_trains'
require_relative 'railway/railway_stations'
require_relative 'railway/railway_routes'
require_relative 'railway/railway_validator'
require_relative 'railway/railway'
require_relative 'seed'

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
