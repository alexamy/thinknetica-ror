# UI helper functions
module Ui
  def self.choose_from(collection)
    select_in_collection(collection)
  rescue StandardError => e
    puts e.message
    retry
  end

  def self.select_in_collection(collection)
    print_collection(collection)
    index = get_input('your option').to_i
    raise 'Unknown index' unless index.between?(0, collection.size - 1)

    collection[index]
  end

  def self.print_collection(collection)
    raise 'No elements' if collection.empty?

    collection.each.with_index do |item, index|
      Ui.print_collection_element(item, index)
      yield(item, index) if block_given?
    end
  end

  def self.print_collection_element(item, index)
    puts "#{index}. #{item}"
  end

  def self.get_input(message)
    print "#{message.capitalize}: "
    gets.chomp
  end

  def self.enter_key_wait
    print 'Press Enter to continue'
    puts
    gets
  end
end
