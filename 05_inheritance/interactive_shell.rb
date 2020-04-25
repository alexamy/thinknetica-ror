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
    loop do
      puts title
      selected = Ui.choose_from(entries)
      return if selected == stop_word

      method = selected.downcase.gsub(' ', '_')

      puts
      target.public_send(method)
      puts

      print 'Press any key'
      puts
      gets
    end
  end
end
