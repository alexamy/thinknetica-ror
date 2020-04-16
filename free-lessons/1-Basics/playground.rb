class String
  def - other
    self.gsub other, ''
  end
end

puts "abaab" - "a"
