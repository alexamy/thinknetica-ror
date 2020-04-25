# Interactive shell
class InteractiveShell
  attr_reader :target, :title, :entries, :stop_word

  def initialize(target, title, entries, stop_word)
    @target = target
    @title = title
    @entries = entries
    @stop_word = stop_word
  end

  def run
    puts "Welcome to #{title}"
    loop do
      selected = Ui.choose_from(entries)
      return if selected == stop_word

      send_method(selected)
      Ui.any_key_wait
    end
  end

  protected

  def send_method(selected)
    method = selected.downcase.gsub(' ', '_')
    puts
    target.public_send(method)
    puts
  end
end
