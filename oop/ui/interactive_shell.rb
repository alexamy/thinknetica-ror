# Interactive shell
class InteractiveShell
  extend Validation

  attr_reader :target, :title, :entries, :stop_word

  validate :target, :presence
  validate :title, :type, String
  validate :title, :format, /^[A-Z]/
  validate :entries, :presence
  validate :stop_word, :type, String

  def initialize(target, title, entries, stop_word)
    @target = target
    @title = title
    @entries = entries
    @stop_word = stop_word
    validate!
  end

  def run
    puts "Welcome to #{title}!"
    loop do
      selected = Ui.choose_from(entries)
      return if selected == stop_word

      send_method(selected)
      Ui.enter_key_wait
    end
  end

  protected

  def send_method(selected)
    method = selected.downcase.gsub(' ', '_')
    puts
    target.public_send(method)
    puts
  rescue NoMethodError
    raise
  rescue StandardError => e
    puts e.message
  end
end
