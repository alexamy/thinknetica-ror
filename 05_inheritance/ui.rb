# UI helper functions
module Ui
  def self.choose_from(collection)
    loop do
      result = select_in_collection(collection)
      return result if result

      puts 'Unknown index'
    end
  end

  def self.select_in_collection(collection)
    print_collection(collection)
    index = get_input('your option').to_i
    collection[index]
  end

  def self.print_collection(collection)
    collection.each.with_index do |item, index|
      puts "#{index}. #{item}"
    end
  end

  def self.get_input(message)
    print "#{message.capitalize}: "
    gets.chomp
  end
end
