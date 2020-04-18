vowels = {}
vowel_list = 'aeiou'

('a'..'z').each.with_index(1) do |letter, index|
  vowels[letter.to_sym] = index if vowel_list.include?(letter)
end
